import 'package:flutter/material.dart';
import 'breathing_practice_page.dart';

class GuidedSessionPage extends StatefulWidget {
  const GuidedSessionPage({super.key});

  @override
  State<GuidedSessionPage> createState() => _GuidedSessionPageState();
}

class _GuidedSessionPageState extends State<GuidedSessionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _slideUp;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..forward();

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideUp = Tween<double>(
      begin: 40,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildHeader(bool isDark) {
    return FadeTransition(
      opacity: _fadeIn,
      child: Text(
        'A structured session to help reduce stress and increase mindfulness',
        style: TextStyle(
          color: isDark ? Colors.white70 : Colors.black87,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF10131A) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        title: Text(
          'Guided Wellness Session',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(isDark),
            const SizedBox(height: 24),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _slideUp.value),
                  child: Opacity(
                    opacity: _fadeIn.value,
                    child: Column(
                      children: [
                        _AnimatedSessionStep(
                          icon: Icons.air_rounded,
                          color: Colors.blueAccent,
                          stepNumber: '1.',
                          title: 'Breathing Practice (3–5 min)',
                          description:
                              'Guided breathing exercises to reduce heart rate and initiate relaxation',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 16),
                        _AnimatedSessionStep(
                          icon: Icons.self_improvement_rounded,
                          color: Colors.pinkAccent,
                          stepNumber: '2.',
                          title: 'Mindfulness Meditation (5 min)',
                          description:
                              'Deepen awareness and reduce cognitive load through mindfulness',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 16),
                        _AnimatedSessionStep(
                          icon: Icons.directions_run_rounded,
                          color: Colors.green,
                          stepNumber: '3.',
                          title: 'Movement / Body Awareness (2–3 min)',
                          description:
                              'Gentle movements to activate the body and increase somatic awareness',
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            FadeTransition(
              opacity: _fadeIn,
              child: Text(
                'The entire session will take approximately 10–15 minutes to complete',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _fadeIn,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow_rounded, size: 22),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BreathingPracticePage(),
                      ),
                    );
                  },
                  label: const Text('Begin Session'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedSessionStep extends StatefulWidget {
  final String stepNumber;
  final String title;
  final String description;
  final bool isDark;
  final IconData icon;
  final Color color;

  const _AnimatedSessionStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.isDark,
    required this.icon,
    required this.color,
  });

  @override
  State<_AnimatedSessionStep> createState() => _AnimatedSessionStepState();
}

class _AnimatedSessionStepState extends State<_AnimatedSessionStep>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 0.08,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) {
          return Transform.scale(scale: _scale.value, child: child);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: widget.isDark ? const Color(0xFF181C23) : Colors.grey[100],
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.isDark ? Colors.grey[800]! : Colors.grey[300]!,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.08),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0, top: 2),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: widget.color.withOpacity(0.13),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Icon(widget.icon, color: widget.color, size: 22),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.stepNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: widget.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: widget.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
