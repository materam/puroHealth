import 'package:flutter/material.dart';
import '../results/results_screen.dart';

class SensorDataScreen extends StatefulWidget {
  final Map<String, dynamic>? previousAnswers;

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

  double? calculatePhysiologicalScore() {
    double? heartRate = double.tryParse(heartRateController.text);
    double? gsr = double.tryParse(gsrController.text);
    double? temp = double.tryParse(tempController.text);

    if (heartRate == null || gsr == null || temp == null) return null;

    double score = 0;
    int count = 0;

    if (heartRate < 60 || heartRate > 100) {
      score += 1;
    }
    count++;

    if (gsr < 2 || gsr > 15) {
      score += 1;
    }
    count++;

    if (temp < 36.1 || temp > 37.2) {
      score += 1;
    }
    count++;

    return count > 0 ? (score / count) : null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF10131A) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
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
                  'Please enter your current physiological readings. These values are required for a complete and accurate stress assessment.',
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF181C23) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightBlueAccent.withAlpha(
                        (0.08 * 255).toInt(),
                      ),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
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
                    const SizedBox(height: 18),
                    // Heart Rate
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red[300]),
                        const SizedBox(width: 8),
                        Text(
                          'Heart Rate',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black,
                          ),
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
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: '60-100',
                        suffixText: 'bpm',
                        errorText: _heartRateError,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Heart rate is required';
                        }
                        final val = double.tryParse(value);
                        if (val == null) return 'Enter a valid number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    // GSR
                    Row(
                      children: [
                        Icon(Icons.show_chart, color: Colors.blue[300]),
                        const SizedBox(width: 8),
                        Text(
                          'Galvanic Skin Response (GSR)',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black,
                          ),
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
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: '2-15',
                        suffixText: 'µS',
                        errorText: _gsrError,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'GSR is required';
                        }
                        final val = double.tryParse(value);
                        if (val == null) return 'Enter a valid number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    // Temperature
                    Row(
                      children: [
                        Icon(Icons.thermostat, color: Colors.lightBlueAccent),
                        const SizedBox(width: 8),
                        Text(
                          'Body Temperature',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black,
                          ),
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
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: '36.5',
                        suffixText: '°C',
                        errorText: _tempError,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Temperature is required';
                        }
                        final val = double.tryParse(value);
                        if (val == null) return 'Enter a valid number';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
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

                    if (_formKey.currentState?.validate() ?? false) {
                      double? score = calculatePhysiologicalScore();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  ResultsScreen(physiologicalScore: score),
                        ),
                      );
                    }
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
