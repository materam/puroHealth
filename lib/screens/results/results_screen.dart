import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../guided_session.dart';

class ResultsScreen extends StatelessWidget {
  final int? stressScore;
  final double? physiologicalScore;
  final Map<String, dynamic>? previousAnswers;

  const ResultsScreen({
    super.key,
    this.stressScore,
    this.physiologicalScore,
    this.previousAnswers,
  });

  // Evaluate questionnaire score and return a description
  String getStressLevel(int score) {
    if (score <= 13) return "Low";
    if (score <= 26) return "Moderate";
    return "High";
  }

  String getStressAdvice(int score) {
    if (score <= 13) {
      return "Your perceived stress is low. Keep up your healthy habits!";
    } else if (score <= 26) {
      return "Your perceived stress is moderate. Consider relaxation techniques and regular check-ins.";
    } else {
      return "Your perceived stress is high. We recommend you try a guided wellness session.";
    }
  }

  String getPhysioLevel(double? score) {
    if (score == null) return "Unknown";
    if (score < 0.5) return "Normal";
    if (score < 1.5) return "Borderline";
    return "High";
  }

  Color getLevelColor(String level) {
    switch (level) {
      case "Low":
      case "Normal":
        return Colors.green;
      case "Moderate":
      case "Borderline":
        return Colors.orange;
      case "High":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final int score = stressScore ?? previousAnswers?['stressScore'] ?? 0;
    final double? physio =
        physiologicalScore ?? previousAnswers?['physiologicalScore'];
    final String stressLevel = getStressLevel(score);
    final String physioLevel = getPhysioLevel(physio);

    // For graph demo, use dummy or real values
    final double heartRate =
        double.tryParse(
          previousAnswers?['heartRate']?.toString() ??
              previousAnswers?['sensorData']?['heartRate']?.toString() ??
              "80",
        ) ??
        80;
    final double gsr =
        double.tryParse(
          previousAnswers?['gsr']?.toString() ??
              previousAnswers?['sensorData']?['gsr']?.toString() ??
              "7",
        ) ??
        7;
    final double temp =
        double.tryParse(
          previousAnswers?['temp']?.toString() ??
              previousAnswers?['sensorData']?['temp']?.toString() ??
              "36.8",
        ) ??
        36.8;

    bool recommendGuided = stressLevel == "High" || physioLevel == "High";

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF10131A) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Your Stress Assessment",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        children: [
          // Stress Score Card
          Card(
            color: isDark ? const Color(0xFF181C23) : Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.assignment_turned_in,
                    color: getLevelColor(stressLevel),
                    size: 40,
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Questionnaire Score",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Total: $score / 40",
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "Level: ",
                              style: TextStyle(
                                fontSize: 15,
                                color: isDark ? Colors.white60 : Colors.black54,
                              ),
                            ),
                            Text(
                              stressLevel,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: getLevelColor(stressLevel),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          getStressAdvice(score),
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          // Physiological Score Card
          Card(
            color: isDark ? const Color(0xFF181C23) : Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.monitor_heart,
                    color: getLevelColor(physioLevel),
                    size: 40,
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sensor Score",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Status: $physioLevel",
                          style: TextStyle(
                            fontSize: 16,
                            color: getLevelColor(physioLevel),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Based on your heart rate, GSR, and temperature.",
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Sensor Data Graph
          Card(
            color: isDark ? const Color(0xFF181C23) : Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Sensor Data",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 180,
                    child: BarChart(
                      BarChartData(
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 0:
                                    return const Text('Heart');
                                  case 1:
                                    return const Text('GSR');
                                  case 2:
                                    return const Text('Temp');
                                  default:
                                    return const Text('');
                                }
                              },
                            ),
                          ),
                        ),
                        barGroups: [
                          BarChartGroupData(
                            x: 0,
                            barRods: [
                              BarChartRodData(
                                toY: heartRate,
                                color: Colors.redAccent,
                                width: 24,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ],
                          ),
                          BarChartGroupData(
                            x: 1,
                            barRods: [
                              BarChartRodData(
                                toY: gsr,
                                color: Colors.blueAccent,
                                width: 24,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ],
                          ),
                          BarChartGroupData(
                            x: 2,
                            barRods: [
                              BarChartRodData(
                                toY: temp,
                                color: Colors.orangeAccent,
                                width: 24,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _SensorValueBox(
                        label: "Heart Rate",
                        value: "${heartRate.toStringAsFixed(1)} bpm",
                        color: Colors.redAccent,
                      ),
                      _SensorValueBox(
                        label: "GSR",
                        value: "${gsr.toStringAsFixed(1)} µS",
                        color: Colors.blueAccent,
                      ),
                      _SensorValueBox(
                        label: "Temp",
                        value: "${temp.toStringAsFixed(1)} °C",
                        color: Colors.orangeAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          // Recommendation
          if (recommendGuided)
            Card(
              color: Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red,
                      size: 36,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "High Stress Detected",
                      style: TextStyle(
                        color: Colors.red[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "We recommend you start a guided wellness session to help reduce your stress.",
                      style: TextStyle(color: Colors.red[800], fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.spa),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        label: const Text("Start Guided Session"),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GuidedSessionPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (!recommendGuided)
            Card(
              color: Colors.green[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 36),
                    const SizedBox(height: 10),
                    Text(
                      "You're doing well!",
                      style: TextStyle(
                        color: Colors.green[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Keep up your healthy habits and check back regularly.",
                      style: TextStyle(color: Colors.green[800], fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 32),
          // Go to Home Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.home),
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
              label: const Text("Go to Home"),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SensorValueBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SensorValueBox({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(80), width: 1.2),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
