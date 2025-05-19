import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final Map<String, dynamic>? questionnaireAnswers;
  final double? physiologicalScore;

  const ResultsScreen({
    super.key,
    this.questionnaireAnswers,
    this.physiologicalScore,
  });

  @override
  Widget build(BuildContext context) {
    // Example: Calculate total score
    int questionnaireScore = (questionnaireAnswers?['score'] ?? 0) as int;
    double totalScore = questionnaireScore + (physiologicalScore ?? 0);
    String stressLevel;
    Color levelColor;

    if (totalScore < 5) {
      stressLevel = "Low";
      levelColor = Colors.green;
    } else if (totalScore < 10) {
      stressLevel = "Moderate";
      levelColor = Colors.amber;
    } else {
      stressLevel = "High";
      levelColor = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Assessment Results')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overall Stress Level",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text("Stress Level: ", style: TextStyle(fontSize: 20)),
                Chip(
                  label: Text(stressLevel),
                  backgroundColor: levelColor,
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: (totalScore / 15).clamp(0.0, 1.0),
              minHeight: 16,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(levelColor),
            ),
            const SizedBox(height: 32),
            if (stressLevel == "High" || stressLevel == "Moderate")
              ElevatedButton(
                onPressed: () {
                  // Navigate to relaxation guide screen
                },
                child: const Text('Start Relaxation Guide'),
              ),
          ],
        ),
      ),
    );
  }
}
