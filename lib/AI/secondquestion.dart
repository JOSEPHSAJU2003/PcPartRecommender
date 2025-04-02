import 'package:flutter/material.dart';
import 'thirdquestion.dart';

class BudgetRangePage extends StatefulWidget {
  final String category; // Declare the variable to receive category

  // Constructor to receive category
  BudgetRangePage({this.category = "No Specific Category"});

  @override
  _BudgetRangePageState createState() => _BudgetRangePageState();
}

class _BudgetRangePageState extends State<BudgetRangePage> {
  double _budget = 50000; // Initial budget value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "What is your budget range for the PC build?",
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Slider(
              value: _budget,
              min: 50000,
              max: 500000,
              divisions: 10, // Creates steps of 1000
              activeColor: Colors.cyan,
              inactiveColor: Colors.grey,
              label: "₹${_budget.toInt()}",
              onChanged: (value) {
                setState(() {
                  _budget = value;
                });
              },
            ),
            Text(
              "₹${_budget.toInt()}",
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ProcessorQuestionPage(
                          budget: _budget,
                          category: widget.category,
                        ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
              ),
              child: Icon(Icons.check, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: BudgetRangePage(),
    ),
  );
}
