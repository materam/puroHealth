import 'package:flutter/material.dart';
import 'dart:async';
import 'meditation_practice_screen.dart';

class BreathingPracticePage extends StatefulWidget {
  const BreathingPracticePage({super.key});

  @override
  State<BreathingPracticePage> createState() => _BreathingPracticePageState();
}

class _BreathingPracticePageState extends State<BreathingPracticePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isBreathing = false;
  bool isPaused = false;
  bool isFinished = false;
  int selectedDuration = 3; // in minutes
  int secondsLeft = 0;
  Timer? _timer;
  bool isInhale = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..addStatusListener((status) {
      if (!isBreathing) return;
      if (status == AnimationStatus.completed) {
        setState(() => isInhale = false);
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() => isInhale = true);
        _controller.forward();
      }
    });
    _animation = Tween<double>(
      begin: 80,
      end: 180,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    secondsLeft = selectedDuration * 60;
  }

  void startBreathing() {
    setState(() {
      isBreathing = true;
      isPaused = false;
      isFinished = false;
      secondsLeft = selectedDuration * 60;
      isInhale = true;
    });
    _controller.forward();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft <= 1) {
        finishBreathing();
      } else {
        setState(() {
          secondsLeft--;
        });
      }
    });
  }

  void pauseBreathing() {
    setState(() {
      isPaused = true;
      isBreathing = false;
    });
    _controller.stop();
    _timer?.cancel();
  }

  void resumeBreathing() {
    setState(() {
      isPaused = false;
      isBreathing = true;
    });
    _controller.forward();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft <= 1) {
        finishBreathing();
      } else {
        setState(() {
          secondsLeft--;
        });
      }
    });
  }

  void finishBreathing() {
    if (!mounted) return;
    setState(() {
      isBreathing = false;
      isPaused = false;
      isFinished = true;
      secondsLeft = 0;
    });
    _controller.stop();
    _controller.reset();
    _timer?.cancel();
  }

  void resetBreathing() {
    setState(() {
      isBreathing = false;
      isPaused = false;
      isFinished = false;
      secondsLeft = selectedDuration * 60;
      isInhale = true;
    });
    _controller.reset();
    _timer?.cancel();
  }

  Widget buildTimeSelector() {
    List<int> times = [1, 2, 3, 4, 5, 6];
    return Wrap(
      spacing: 12,
      children:
          times.map((min) {
            final bool isSelected = selectedDuration == min;
            return ChoiceChip(
              label: Text('$min min'),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  selectedDuration = min;
                  if (!isBreathing && !isPaused && !isFinished) {
                    secondsLeft = selectedDuration * 60;
                  }
                });
              },
            );
          }).toList(),
    );
  }

  String get timerText {
    final min = (secondsLeft ~/ 60).toString().padLeft(2, '0');
    final sec = (secondsLeft % 60).toString().padLeft(2, '0');
    return "$min:$sec";
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor =
        isDark ? const Color(0xFF10131A) : const Color(0xFFF5F8FF);
    final Color mainColor = Colors.pinkAccent;
    final Color textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Breathing',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (!isBreathing && !isPaused && !isFinished)
            IconButton(
              icon: Icon(Icons.skip_next, color: mainColor),
              tooltip: "Skip",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MeditationPracticePage(),
                  ),
                );
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: CircularProgressIndicator(
                        value:
                            isBreathing || isPaused || isFinished
                                ? 1 - (secondsLeft / (selectedDuration * 60))
                                : 0,
                        strokeWidth: 10,
                        backgroundColor:
                            isDark ? Colors.white12 : Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Container(
                          width: _animation.value,
                          height: _animation.value,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainColor.withAlpha(30),
                            boxShadow: [
                              BoxShadow(
                                color: mainColor.withAlpha(60),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                Text(
                  timerText,
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isFinished
                      ? "Session Complete"
                      : isBreathing
                      ? (isInhale ? "Inhale" : "Exhale")
                      : isPaused
                      ? "Paused"
                      : "Ready",
                  style: TextStyle(fontSize: 18, color: mainColor),
                ),
                const SizedBox(height: 4),
                Text(
                  isBreathing || isPaused ? "left until break" : "",
                  style: TextStyle(fontSize: 14, color: mainColor),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Breath to reduce Stress',
              style: TextStyle(fontSize: 16, color: textColor),
            ),
            const SizedBox(height: 24),
            const Text('Time', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            buildTimeSelector(),
            const SizedBox(height: 32),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!isBreathing && !isPaused && !isFinished)
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.play_arrow),
                              label: const Text("Start"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: startBreathing,
                            ),
                          ),
                        if (isBreathing)
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.pause),
                              label: const Text("Pause"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: pauseBreathing,
                            ),
                          ),
                        if (isPaused)
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.play_arrow),
                              label: const Text("Resume"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: resumeBreathing,
                            ),
                          ),
                        if (isFinished)
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.replay),
                              label: const Text("Restart"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: resetBreathing,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Next button: only enabled if paused or finished
                    if ((isPaused || isFinished) && secondsLeft == 0)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text("Next"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const MeditationPracticePage(),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
