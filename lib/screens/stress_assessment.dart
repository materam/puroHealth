import 'package:flutter/material.dart';
import 'questionnaire/stress_questions.dar.dart';

class StressAssessmentPage extends StatelessWidget {
  const StressAssessmentPage({super.key});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Stress Evaluation',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'Step 1 of 3: Select the category that best\ndescribes you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: isDark ? Colors.grey[400] : Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _CategoryCard(
              title: 'Student',
              description: 'Questions adapted for academic stress evaluation',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => StressQuestionsPage(category: 'Student'),
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            _CategoryCard(
              title: 'Employee',
              description:
                  'Questions adapted for work-related stress evaluation',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => StressQuestionsPage(category: 'Employee'),
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            _CategoryCard(
              title: 'General',
              description: 'General stress evaluation questions',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => StressQuestionsPage(category: 'General'),
                  ),
                );
              },
            ),
            const Spacer(),
            Center(
              child: Text(
                '© 2025 Smart Health Monitoring. All rights reserved.',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.grey[600] : Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF181C23) : Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 15,
                color: isDark ? Colors.grey[400] : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
