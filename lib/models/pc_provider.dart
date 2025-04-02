import 'package:flutter/foundation.dart';

class PCProvider extends ChangeNotifier {
  // Add your PC part selection state here
  String? processor;
  String? cooling;
  String? gpu;
  String? ram;
  String? storage;
  String? psu;
  String? motherboard;
  String? category;

  void updateProcessor(String value) {
    processor = value;
    notifyListeners();
  }

  void updateCooling(String value) {
    cooling = value;
    notifyListeners();
  }

  void updateGpu(String value) {
    gpu = value;
    notifyListeners();
  }

  void updateRam(String value) {
    ram = value;
    notifyListeners();
  }

  void updateStorage(String value) {
    storage = value;
    notifyListeners();
  }

  void updatePsu(String value) {
    psu = value;
    notifyListeners();
  }

  void updateMotherboard(String value) {
    motherboard = value;
    notifyListeners();
  }

  void updateCategory(String value) {
    category = value;
    notifyListeners();
  }
}