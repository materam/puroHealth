import 'package:flutter/material.dart';
import '../sensor_data/sensor_data_screen.dart';

class StressQuestionPage extends StatefulWidget {
  final String category;
  const StressQuestionPage({super.key, required this.category});

  @override
  State<StressQuestionPage> createState() => _StressQuestionPageState();
}

class _StressQuestionPageState extends State<StressQuestionPage> {
  late List<String> questions;
  final List<String> options = [
    "Never", // 0
    "Almost Never", // 1
    "Sometimes", // 2
    "Fairly Often", // 3
    "Very Often", // 4
  ];
  int current = 0;
  List<int?> answers = [];

  @override
  void initState() {
    super.initState();
    questions = _getQuestions(widget.category);
    answers = List.filled(questions.length, null);
  }

  List<String> _getQuestions(String category) {
    switch (category) {
      case 'Student':
        return [
          "In the past month, how often have you felt overwhelmed by your academic workload?",
          "How often have you worried about upcoming exams or assignments?",
          "How often have you felt pressure to achieve high grades?",
          "How often have you felt you had too many commitments (classes, clubs, etc.)?",
          "How often have you felt you lacked time for relaxation or hobbies?",
          "How often have you felt isolated from friends or classmates?",
          "How often have you had trouble sleeping due to academic stress?",
          "How often have you felt anxious about your future career?",
          "How often have you felt unsupported by teachers or faculty?",
          "How often have you felt your stress affected your academic performance?",
        ];
      case 'Employee':
        return [
          "In the past month, how often have you felt stressed by your workload?",
          "How often have you worried about meeting deadlines at work?",
          "How often have you felt pressure from your supervisor or management?",
          "How often have you felt your work-life balance was poor?",
          "How often have you felt unappreciated at your job?",
          "How often have you felt anxious about job security?",
          "How often have you experienced conflict with colleagues?",
          "How often have you felt unable to disconnect from work after hours?",
          "How often have you felt your job affected your health?",
          "How often have you felt your stress impacted your work performance?",
        ];
      default:
        return [
          "In the last month, how often have you felt nervous or stressed?",
          "How often have you felt unable to control important things in your life?",
          "How often have you felt confident about your ability to handle personal problems?",
          "How often have you felt that things were going your way?",
          "How often have you found that you could not cope with all the things you had to do?",
          "How often have you been able to control irritations in your life?",
          "How often have you felt that you were on top of things?",
          "How often have you been angered because of things that were outside of your control?",
          "How often have you felt difficulties were piling up so high that you could not overcome them?",
          "How often have you felt relaxed and at ease?",
        ];
    }
  }

  void next() {
    if (current < questions.length - 1) {
      setState(() => current++);
    } else {
      // Calculate total stress score
      int totalScore = answers.fold(0, (sum, val) => sum + (val ?? 0));
      // Pass the score to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => SensorDataScreen(
                previousAnswers: {
                  'category': widget.category,
                  'answers': answers,
                  'stressScore': totalScore,
                },
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF10131A) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
          decoration: BoxDecoration(
            color: isDark ? Colors.white10 : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Question ",
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: "${current + 1}",
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: " of ${questions.length}",
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 24),
              child: LinearProgressIndicator(
                value: (current + 1) / questions.length,
                backgroundColor: isDark ? Colors.white12 : Colors.grey[200],
                color: Colors.lightBlueAccent,
                minHeight: 5,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            // Question
            Text(
              questions[current],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 32),
            // Options
            ...List.generate(options.length, (i) {
              final selected = answers[current] == i;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color:
                          selected
                              ? Colors.lightBlueAccent.withAlpha(
                                (0.08 * 255).toInt(),
                              )
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow:
                          selected
                              ? [
                                BoxShadow(
                                  color: Colors.lightBlueAccent.withAlpha(
                                    (0.25 * 255).toInt(),
                                  ),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                              : [],
                    ),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color:
                              selected
                                  ? Colors.lightBlueAccent
                                  : (isDark
                                      ? Colors.white24
                                      : Colors.grey[400]!),
                          width: 2,
                        ),
                        backgroundColor: Colors.transparent,
                        foregroundColor:
                            selected ? Colors.lightBlueAccent : textColor,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        setState(() => answers[current] = i);
                      },
                      child: Center(child: Text(options[i])),
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            // Next button
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.lightBlueAccent,
                onPressed: answers[current] != null ? next : null,
                child: const Icon(Icons.arrow_upward, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
