import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MeditationPracticePage extends StatefulWidget {
  const MeditationPracticePage({super.key});

  @override
  State<MeditationPracticePage> createState() => _MeditationPracticePageState();
}

class _MeditationPracticePageState extends State<MeditationPracticePage>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _player;
  bool isPlaying = false;
  Duration audioDuration = const Duration(minutes: 13, seconds: 50);
  Duration audioPosition = Duration.zero;
  late AnimationController _animationController;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.setAsset('assets/audio/meditation.mp3');
    _player.positionStream.listen((pos) {
      setState(() {
        audioPosition = pos;
      });
    });
    _player.durationStream.listen((dur) {
      if (dur != null) {
        setState(() {
          audioDuration = dur;
        });
      }
    });
    _player.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
      });
      if (state.playing) {
        _animationController.repeat(reverse: true);
      } else {
        _animationController.stop();
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _blinkAnimation = Tween<double>(begin: 0.15, end: 0.45).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  Future<void> playPauseAudio() async {
    if (isPlaying) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  @override
  void dispose() {
    _player.dispose();
    _animationController.dispose();
    super.dispose();
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds % 60)}";
  }

  void goToMovementPractice(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/movement-practice');
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final double albumSize = media.size.width * 0.6;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top bar
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Text(
                    "Now Playing",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: media.size.height * 0.03),
              // Animated album image with pink blinking border
              Center(
                child: AnimatedBuilder(
                  animation: _blinkAnimation,
                  builder: (context, child) {
                    return Container(
                      width: albumSize + 32,
                      height: albumSize + 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pinkAccent.withOpacity(
                              _blinkAnimation.value,
                            ),
                            blurRadius: 32,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: Container(
                        width: albumSize,
                        height: albumSize,
                        decoration: BoxDecoration(
                          color: const Color(0xFF9F8DFB),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(
                                (0.08 * 255).toInt(),
                              ),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/images/Meditation.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: media.size.height * 0.04),
              // Titles
              const Text(
                "Meditation",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "Open your heart",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: media.size.height * 0.045),
              // Progress bar
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 7,
                  ),
                  overlayShape: SliderComponentShape.noOverlay,
                  trackHeight: 4,
                  activeTrackColor: Colors.pinkAccent,
                  inactiveTrackColor: Colors.pinkAccent.withOpacity(0.2),
                  thumbColor: Colors.pinkAccent,
                ),
                child: Slider(
                  min: 0,
                  max: audioDuration.inSeconds.toDouble(),
                  value:
                      audioPosition.inSeconds
                          .clamp(0, audioDuration.inSeconds)
                          .toDouble(),
                  onChanged: (value) async {
                    final pos = Duration(seconds: value.toInt());
                    await _player.seek(pos);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(audioPosition),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      formatDuration(audioDuration),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.replay_10,
                      color: Colors.pinkAccent,
                      size: 32,
                    ),
                    onPressed: () async {
                      final newPos =
                          audioPosition - const Duration(seconds: 10);
                      await _player.seek(
                        newPos > Duration.zero ? newPos : Duration.zero,
                      );
                    },
                  ),
                  const SizedBox(width: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(18),
                      elevation: 8,
                    ),
                    onPressed: playPauseAudio,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (child, anim) =>
                              ScaleTransition(scale: anim, child: child),
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        key: ValueKey<bool>(isPlaying),
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  IconButton(
                    icon: const Icon(
                      Icons.forward_10,
                      color: Colors.pinkAccent,
                      size: 32,
                    ),
                    onPressed: () async {
                      final newPos =
                          audioPosition + const Duration(seconds: 10);
                      await _player.seek(
                        newPos < audioDuration ? newPos : audioDuration,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: media.size.height * 0.03),
              // Next button to go to Movement Practice (smaller and professional)
              SizedBox(
                width: 210,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    goToMovementPractice(context);
                  },
                  child: const Text("Continue to Movement Practice"),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
