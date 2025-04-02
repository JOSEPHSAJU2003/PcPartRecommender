import 'package:flutter/material.dart';
import 'display.dart';

class PCPreferencesPage extends StatefulWidget {
    final String performance;
  final int storage;
  final String processor;
  final String cooling;
  final double budget;
  final String category;

  // ✅ Constructor with Default Values
  const PCPreferencesPage({
    this.performance = "Any type",
    this.storage = 500,
    this.processor = "Any",
    this.cooling = "Any",
    this.budget = 500000,
    this.category = "General",
  });




  @override
  _PCPreferencesPageState createState() => _PCPreferencesPageState();
}

class _PCPreferencesPageState extends State<PCPreferencesPage> {
  String selectedAppearance = ""; // To track selected appearance preference
  String futureUpgrade = ""; // To track future upgrade plans

  // Method to navigate to the ResultsPage and pass the selected data
  void _navigateToResultsPage() {
    // Passing the selected data to the ResultsPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPage(
          selectedAppearance: selectedAppearance,
          futureUpgrade: futureUpgrade,performance:widget.performance,storage:widget.storage,processor:widget.processor,cooling:widget.cooling,budget:widget.budget,category:widget.category
        ),
      ),
    );
  }

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
              "Do you have any preferences for the PC appearance?",
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
                _buildOptionButton("White", selectedAppearance, (value) {
                  setState(() {
                    selectedAppearance = value;
                  });
                }),
                _buildOptionButton("Black", selectedAppearance, (value) {
                  setState(() {
                    selectedAppearance = value;
                  });
                }),
                _buildOptionButton("Mix", selectedAppearance, (value) {
                  setState(() {
                    selectedAppearance = value;
                  });
                }),
              ],
            ),
            SizedBox(height: 30),

            // Second Question
            Text(
              "Do you plan on upgrading the PC in the future?",
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
                _buildOptionButton("Yes", futureUpgrade, (value) {
                  setState(() {
                    futureUpgrade = value;
                  });
                }),
                _buildOptionButton("No", futureUpgrade, (value) {
                  setState(() {
                    futureUpgrade = value;
                  });
                }),
              ],
            ),
            SizedBox(height: 40),

            // Submit Button
            ElevatedButton(
              onPressed: _navigateToResultsPage, // Navigate to ResultsPage
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build rectangular option buttons
  Widget _buildOptionButton(
      String title, String selectedValue, Function(String) onPressed) {
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
