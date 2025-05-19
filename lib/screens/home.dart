import 'package:flutter/material.dart';
import 'stress_assessment.dart';
import 'guided_session.dart';
import '../main.dart'; // adjust the path if needed

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              themeNotifier.value =
                  themeNotifier.value == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark;
            },
          ),
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Welcome to Smart Health❤️‍🩹',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            _FeatureCard(
              title: 'Stress Assessment',
              subtitle: 'Complete a comprehensive stress evaluation',
              description:
              'Answer a few questions and provide optional biometric data for a complete assessment of your current stress levels.',
              buttonText: 'Start Assessment',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StressAssessmentPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            _FeatureCard(
              title: 'Guided Wellness Session',
              subtitle: 'Begin a structured relaxation practice',
              description:
              'Follow a 10-15 minute guided session with breathing exercises, mindfulness meditation, and gentle movement.',
              buttonText: 'Start Session',
              onPressed: () {
                // Navigate to the GuidedSessionPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GuidedSessionPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const _FeatureCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF181C23) : Colors.grey[100],
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          // Corrected usage for border color opacity - using .r, .g, .b
          color: isDark
              ? Color.fromRGBO(Colors.grey[800]!.r.toInt(), Colors.grey[800]!.g.toInt(), Colors.grey[800]!.b.toInt(), 1.0)
              : Color.fromRGBO(Colors.grey[300]!.r.toInt(), Colors.grey[300]!.g.toInt(), Colors.grey[300]!.b.toInt(), 1.0),
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
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
              color: isDark ? Colors.grey[400] : Colors.grey[700],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.grey[300] : Colors.grey[800],
            ),
          ),
          const SizedBox(height: 20),
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
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}
