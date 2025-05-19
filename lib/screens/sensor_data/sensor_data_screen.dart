import 'package:flutter/material.dart';
import '../results/results_screen.dart';

class SensorDataScreen extends StatefulWidget {
  final Map<String, dynamic>?
  previousAnswers; // If you want to pass previous data

  const SensorDataScreen({super.key, this.previousAnswers});

  @override
  State<SensorDataScreen> createState() => _SensorDataScreenState();
}

class _SensorDataScreenState extends State<SensorDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController heartRateController = TextEditingController();
  final TextEditingController gsrController = TextEditingController();
  final TextEditingController tempController = TextEditingController();

  String? _heartRateError;
  String? _gsrError;
  String? _tempError;

  // Example: Calculate a normalized score based on medical research
  double? calculatePhysiologicalScore() {
    double? heartRate = double.tryParse(heartRateController.text);
    double? gsr = double.tryParse(gsrController.text);
    double? temp = double.tryParse(tempController.text);

    // Example normal ranges (can be adjusted based on research)
    // Heart Rate: 60-100 bpm, GSR: 2-15 µS, Temp: 36.1-37.2°C
    if (heartRate == null && gsr == null && temp == null) return null;

    double score = 0;
    int count = 0;

    if (heartRate != null) {
      // Lower score if within normal range, higher if outside
      if (heartRate < 60 || heartRate > 100) {
        score += 1;
      }
      count++;
    }
    if (gsr != null) {
      if (gsr < 2 || gsr > 15) {
        score += 1;
      }
      count++;
    }
    if (temp != null) {
      if (temp < 36.1 || temp > 37.2) {
        score += 1;
      }
      count++;
    }
    return count > 0 ? (score / count) : null; // 0 = normal, 1 = all abnormal
  }

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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Physiological Data',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Step 2 of 3: Enter your physiological measurements',
                  style: TextStyle(
                    fontSize: 17,
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'These readings help provide a more complete stress assessment. ',
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 4, bottom: 20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Optional',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF181C23) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sensor Readings',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Enter any measurements you have available.\nLeave fields blank if you don't have the data.",
                      style: TextStyle(
                        fontSize: 15,
                        color: isDark ? Colors.grey[400] : Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Heart Rate
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red[300]),
                        const SizedBox(width: 8),
                        Text(
                          'Heart Rate',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Tooltip(
                          message: 'Normal: 60-100 bpm',
                          child: Icon(
                            Icons.info_outline,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: heartRateController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '60-100',
                        suffixText: 'bpm',
                        errorText: _heartRateError,
                      ),
                    ),
                    const SizedBox(height: 18),
                    // GSR
                    Row(
                      children: [
                        Icon(Icons.show_chart, color: Colors.blue[300]),
                        const SizedBox(width: 8),
                        Text(
                          'Galvanic Skin Response (GSR)',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Tooltip(
                          message: 'Normal: 2-15 µS',
                          child: Icon(
                            Icons.info_outline,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: gsrController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '2-15',
                        suffixText: 'µS',
                        errorText: _gsrError,
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Temperature
                    Row(
                      children: [
                        Icon(Icons.thermostat, color: Colors.lightBlueAccent),
                        const SizedBox(width: 8),
                        Text(
                          'Body Temperature',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Tooltip(
                          message: 'Normal: 36.1-37.2 °C',
                          child: Icon(
                            Icons.info_outline,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: tempController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '36.5',
                        suffixText: '°C',
                        errorText: _tempError,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
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
                    setState(() {
                      _heartRateError = null;
                      _gsrError = null;
                      _tempError = null;
                    });

                    double? score = calculatePhysiologicalScore();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                ResultsScreen(physiologicalScore: score),
                      ),
                    );
                  },
                  child: const Text('Next  →'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
