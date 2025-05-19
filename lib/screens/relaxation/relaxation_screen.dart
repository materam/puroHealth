import 'package:flutter/material.dart';

class RelaxationScreen extends StatefulWidget {
  const RelaxationScreen({super.key});

  @override
  State<RelaxationScreen> createState() => _RelaxationScreenState();
}

class _RelaxationScreenState extends State<RelaxationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Relaxation Techniques")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Breathe Deeply",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Take a moment to focus on your breathing. Inhale deeply through your nose, hold for a few seconds, and exhale slowly through your mouth.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              "Progressive Muscle Relaxation",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Tense and then relax each muscle group in your body. Start from your toes and work your way up to your head.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              "Mindfulness",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Sit quietly and focus on your natural breathing or on a word or “mantra” that you repeat silently. Let thoughts come and go without judgment.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              "Guided Imagery",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Visualize a peaceful place, such as a beach or a forest. Imagine the sights, sounds, and smells to immerse yourself fully in the scene.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
