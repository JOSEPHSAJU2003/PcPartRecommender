import 'package:flutter/material.dart';
import 'fourthquestion.dart'; // Import the next page

class ProcessorQuestionPage extends StatefulWidget {
  final double budget;
  final String category;

  // Constructor to receive budget and category
  ProcessorQuestionPage({this.budget = 500000, this.category = "General"});

  @override
  _ProcessorQuestionPageState createState() => _ProcessorQuestionPageState();
}

class _ProcessorQuestionPageState extends State<ProcessorQuestionPage> {
  String selectedProcessor = ""; // Track selected processor
  String selectedCooling = ""; // Track selected cooling solution

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // First Question
              Text(
                "What processor do you prefer?",
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Even spacing
                children: [
                  _buildOptionButton("Intel", selectedProcessor, (value) {
                    setState(() => selectedProcessor = value);
                  }),
                  SizedBox(width: 10), // Space between buttons
                  _buildOptionButton("AMD", selectedProcessor, (value) {
                    setState(() => selectedProcessor = value);
                  }),
                  SizedBox(width: 10), // Space between buttons
                  _buildOptionButton("Any", selectedProcessor, (value) {
                    setState(() => selectedProcessor = value);
                  }),
                ],
              ),
              SizedBox(height: 30),

              // Second Question
              Text(
                "Are you interested in a specific cooling solution?",
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Even spacing
                children: [
                  _buildOptionButton("Air Cooling", selectedCooling, (value) {
                    setState(() => selectedCooling = value);
                  }),
                  SizedBox(width: 10), // Space between buttons
                  _buildOptionButton("Liquid Cooling", selectedCooling, (value) {
                    setState(() => selectedCooling = value);
                  }),
                  SizedBox(width: 10), // Space between buttons
                  _buildOptionButton("Any", selectedCooling, (value) {
                    setState(() => selectedCooling = value);
                  }),
                ],
              ),
              SizedBox(height: 40),

              // Confirm Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to next page with selected answers
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PerformanceAndStoragePage(
                        processor: selectedProcessor,
                        cooling: selectedCooling,
                        budget: widget.budget,
                        category: widget.category,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan, // Button background color
                  shape: CircleBorder(), // Circular button
                  padding: EdgeInsets.all(16), // Padding inside the button
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white, // Tick icon color
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build option buttons
  Widget _buildOptionButton(
      String title, String selectedValue, Function(String) onPressed) {
    bool isSelected = selectedValue == title; // Check if selected

    return GestureDetector(
      onTap: () => onPressed(title),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.cyan : Colors.grey[800], // Highlight if selected
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Button padding
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white, // Text color
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
