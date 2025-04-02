import 'package:flutter/material.dart';
import 'fifthqueston.dart'; // Import DisplayPage

class PerformanceAndStoragePage extends StatefulWidget {
  final String processor;
  final String cooling;
  final double budget;
  final String category;
  PerformanceAndStoragePage({
    this.cooling = "any",
    this.processor = "any",
    this.budget = 500000,
    this.category = "General",
  });
  @override
  _PerformanceAndStoragePageState createState() =>
      _PerformanceAndStoragePageState();
}

class _PerformanceAndStoragePageState extends State<PerformanceAndStoragePage> {
  String selectedPerformance = ""; // To track selected performance level
  double storage = 500; // Initial storage value in GB
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
            // First Question
            Text(
              "What level of performance are you expecting?",
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOptionButton("Basic", selectedPerformance, (value) {
                  setState(() {
                    selectedPerformance = value;
                  });
                }),
                _buildOptionButton("Moderate", selectedPerformance, (value) {
                  setState(() {
                    selectedPerformance = value;
                  });
                }),
                _buildOptionButton("High-End", selectedPerformance, (value) {
                  setState(() {
                    selectedPerformance = value;
                  });
                }),
              ],
            ),
            SizedBox(height: 30),

            // Second Question
            Text(
              "How much storage do you think you need?",
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Slider(
              value: storage,
              min: 500,
              max: 5000,
              divisions: 45, // Creates steps of ~100 GB
              activeColor: Colors.cyan,
              inactiveColor: Colors.grey,
              label: "${storage.toInt()} GB",
              onChanged: (value) {
                setState(() {
                  storage = value;
                });
              },
            ),
            Text(
              "${storage.toInt()} GB",
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),

            // Submit Button - Navigate to DisplayPage
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => PCPreferencesPage(
                          performance:
                              selectedPerformance.isNotEmpty
                                  ? selectedPerformance
                                  : "Not Selected",
                          storage: storage.toInt(),
                          processor: widget.processor,
                          cooling: widget.cooling,
                          budget: widget.budget,
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

  // Helper function to build rectangular option buttons
  Widget _buildOptionButton(
    String title,
    String selectedValue,
    Function(String) onPressed,
  ) {
    bool isSelected = selectedValue == title;

    return GestureDetector(
      onTap: () {
        onPressed(title);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.cyan : Colors.grey[800],
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
