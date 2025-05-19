import 'package:flutter/material.dart'; // <-- Import your sensor data screen
import '../sensor_data/sensor_data_screen.dart'; // adjust path if needed

class StressQuestionsPage extends StatefulWidget {
  final String category;
  const StressQuestionsPage({super.key, required this.category});

  @override
  State<StressQuestionsPage> createState() => _StressQuestionsPageState();
}

class _StressQuestionsPageState extends State<StressQuestionsPage> {
  late List<String> questions;
  List<int?> answers = List.filled(10, null);

  @override
  void initState() {
    super.initState();
    questions = _getQuestions(widget.category);
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

  final List<String> options = [
    "Never",
    "Almost Never",
    "Sometimes",
    "Fairly Often",
    "Very Often",
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF10131A) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Smart',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              TextSpan(
                text: ' Health',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.brightness_6), onPressed: () {}),
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            Text(
              'Perceived Stress Scale',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Step 1 of 3: Answer all 10 questions about your feelings and thoughts during the last month',
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.grey[400] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Category: ${widget.category}',
              style: TextStyle(
                fontSize: 15,
                color: isDark ? Colors.grey[400] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(10, (index) {
              return Card(
                color: isDark ? const Color(0xFF181C23) : Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        questions[index],
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(options.length, (optIdx) {
                        return RadioListTile<int>(
                          value: optIdx,
                          groupValue: answers[index],
                          onChanged: (val) {
                            setState(() {
                              answers[index] = val;
                            });
                          },
                          title: Text(
                            options[optIdx],
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          activeColor: Colors.lightBlueAccent,
                          contentPadding: EdgeInsets.zero,
                        );
                      }),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  // Check if all questions are answered
                  if (answers.any((a) => a == null)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please answer all questions before proceeding.',
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SensorDataScreen(),
                      ),
                    );
                  }
                },
                child: const Text('Next  →'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
