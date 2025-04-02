import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final String selectedAppearance;
  final String futureUpgrade;
  final String performance;
  final int storage;
  final String processor;
  final String cooling;
  final double budget;
  final String category;

  // Constructor to receive the variables
  ResultsPage({
    required this.selectedAppearance,
    required this.futureUpgrade,
    required this.performance,
    required this.storage,
    required this.processor,
    required this.cooling,
    required this.budget,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Results')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Selected Appearance: $selectedAppearance',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Future Upgrade: $futureUpgrade',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text('Performance: $performance', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Storage: $storage', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Processor: $processor', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Cooling: $cooling', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Budget: $budget', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Category: $category', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
