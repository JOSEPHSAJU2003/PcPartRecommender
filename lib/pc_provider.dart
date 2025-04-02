import 'package:flutter/material.dart';

class PCProvider extends ChangeNotifier {
  // Selected PC Parts and their images
  String? selectedCPU;
  String? cpuImage;

  String? selectedGPU;
  String? gpuImage;

  String? selectedMotherboard;
  String? motherboardImage;

  String? selectedRAM;
  String? ramImage;

  String? selectedStorage;
  String? storageImage;

  String? selectedPowerSupply;
  String? psuImage;

  String? selectedCase;
  String? caseImage;

  //my addings
  String? socketType;
  String? ramType;
  int tdp = 0;
  String? formfactor;

  void updateCPU(String cpu, String image, String sockettype, String tDp) {
    selectedCPU = cpu;
    cpuImage = image;
    socketType = sockettype;

    // Ensure tDp is parsed as an integer, set default (e.g., 0) if parsing fails
    tdp = int.tryParse(tDp) ?? 0; // Default to 0 if the string cannot be parsed

    notifyListeners(); // Notify listeners to update the UI
  }

  void updateGPU(String gpu, String image) {
    selectedGPU = gpu;
    gpuImage = image;
    notifyListeners();
  }

  void updateMotherboard(String motherboard, String image, String ramtype, String ff) {
    selectedMotherboard = motherboard;
    motherboardImage = image;
    ramType = ramtype;
    formfactor = ff;
    notifyListeners();
  }

  void updateRAM(String ram, String image) {
    selectedRAM = ram;
    ramImage = image;
    notifyListeners();
  }

  void updateStorage(String storage, String image) {
    selectedStorage = storage;
    storageImage = image;
    notifyListeners();
  }

  void updatePowerSupply(String psu, String image) {
    selectedPowerSupply = psu;
    psuImage = image;
    notifyListeners();
  }

  void updateCase(String pcCase, String image) {
    selectedCase = pcCase;
    caseImage = image;
    notifyListeners();
  }

  // Reset Storage
  void resetStorage() {
    selectedStorage = null;
    storageImage = null;

    notifyListeners();
  }

  // Reset Processor
  void resetCPU() {
    selectedCPU = null;
    cpuImage = null;

    notifyListeners();
  }

  // Reset Ram
  void resetRam() {
    selectedRAM = null;
    ramImage = null;

    notifyListeners();
  }

  // Reset Psu
  void resetPsu() {
    selectedPowerSupply = null;
    psuImage = null;

    notifyListeners();
  }

  // Reset Storage
  void resetMotherboard() {
    selectedMotherboard = null;
    motherboardImage = null;

    notifyListeners();
  }

  // Reset all selections
  void resetSelections() {
    selectedCPU = null;
    cpuImage = null;

    selectedGPU = null;
    gpuImage = null;

    selectedMotherboard = null;
    motherboardImage = null;

    selectedRAM = null;
    ramImage = null;

    selectedStorage = null;
    storageImage = null;

    selectedPowerSupply = null;
    psuImage = null;

    selectedCase = null;
    caseImage = null;

    notifyListeners();
  }
}
