import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  // Dummy data
  final List<Map<String, String>> history = const [
    {
      'date': '2025-05-01',
      'type': 'Questionnaire',
      'result': 'Moderate Stress',
    },
    {'date': '2025-05-05', 'type': 'Sensor Data', 'result': 'Low Stress'},
    {'date': '2025-05-10', 'type': 'Questionnaire', 'result': 'High Stress'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History & Analysis')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final entry = history[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text('${entry['type']} Assessment'),
              subtitle: Text('Date: ${entry['date']}'),
              trailing: Text(
                entry['result']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
