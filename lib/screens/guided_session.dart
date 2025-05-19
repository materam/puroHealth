import 'package:flutter/material.dart';
import 'dart:async'; // Import for Timer

class GuidedSessionPage extends StatefulWidget {
  const GuidedSessionPage({super.key});

  @override
  // Made the State class public
  GuidedSessionPageState createState() => GuidedSessionPageState();
}

// Removed the underscore to make the State class public
class GuidedSessionPageState extends State<GuidedSessionPage>
    with SingleTickerProviderStateMixin {
  // Timer variables
  Timer? _timer;
  int _start = 15 * 60; // 15 minutes in seconds

  // Animation variables
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    startTimer();

    // Initialize animation controller and animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Animation duration
    )..repeat(reverse: true); // Repeat the animation

    _fadeAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(_animationController);
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    _animationController.dispose(); // Dispose the animation controller
    super.dispose();
  }

  String _printDuration(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF10131A) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Guided Session',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Placeholder for animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: Icon(
                  Icons.favorite, // Example icon for animation
                  size: 100,
                  color: Colors.lightBlueAccent,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Session Timer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _printDuration(_start),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent,
                ),
              ),
              const SizedBox(height: 32),
              // Placeholder for guided content (e.g., text instructions, audio player)
              Text(
                _start > 0 ? 'Take a deep breath...' : 'Session Complete!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: isDark ? Colors.grey[300] : Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
