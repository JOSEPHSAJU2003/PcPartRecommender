import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';

const apiKey =
    'AIzaSyC-0arWda27ocllNsKegOVxAyTaf3pe-0o'; // Replace with your actual API key

class DisplayPage extends StatefulWidget {
  final String selectedAppearance;
  final String futureUpgrade;
  final String performance;
  final int storage;
  final String processor;
  final String cooling;
  final double budget;
  final String category;

  DisplayPage({
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
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  String processor = "Loading...";
  String cooling = "Loading...";
  String gpu = "Loading...";
  String ram = "Loading...";
  String storage = "Loading...";
  String psu = "Loading...";
  String motherboard = "Loading...";
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchSuggestedPC();
  }

  Future<void> _fetchSuggestedPC() async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt = """
You are a JSON API. Provide only a single-line JSON response, no explanations.
Generate a PC configuration within a budget of ₹${widget.budget.toInt()}.
Processor: ${widget.processor}, Cooling: ${widget.cooling}.
Appearance: ${widget.selectedAppearance}, Future Upgrade: ${widget.futureUpgrade}.
Performance: ${widget.performance}, Storage: ${widget.storage}GB, Category: ${widget.category}.

Return only this JSON format:
{"Processor": "value", "Cooling": "value", "GPU": "value", "RAM": "value", "Storage": "value", "PSU": "value", "Motherboard": "value"}
""";

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      String? responseText = response.text;

      // Debugging: Print AI response
      print("AI Response: $responseText");

      if (responseText == null || !responseText.startsWith("{")) {
        throw Exception("Invalid AI Response");
      }

      var decoded = json.decode(responseText);

      setState(() {
        processor = decoded['Processor'] ?? "Not available";
        cooling = decoded['Cooling'] ?? "Not available";
        gpu = decoded['GPU'] ?? "Not available";
        ram = decoded['RAM'] ?? "Not available";
        storage = decoded['Storage'] ?? "Not available";
        psu = decoded['PSU'] ?? "Not available";
        motherboard = decoded['Motherboard'] ?? "Not available";
        _isLoading = false;
        _hasError = false;
      });
    } catch (e) {
      print("Error fetching AI response: $e");
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  Widget buildPCPartCard(String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Suggested PC Build')),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _hasError
              ? Center(
                child: Text(
                  "Failed to fetch PC build. Please try again.",
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              )
              : Padding(
                padding: EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    buildPCPartCard("Processor", processor),
                    buildPCPartCard("Cooling", cooling),
                    buildPCPartCard("GPU", gpu),
                    buildPCPartCard("RAM", ram),
                    buildPCPartCard("Storage", storage),
                    buildPCPartCard("PSU", psu),
                    buildPCPartCard("Motherboard", motherboard),
                  ],
                ),
              ),
    );
  }
}
