import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pc_provider.dart';
import 'harddisk.dart';
import 'processor.dart';
import 'ram.dart';
import 'motherboard.dart';
import 'psu.dart';
import 'pc_cases.dart';

class PCSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pcProvider = context.watch<PCProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Build Your PC")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSelectionItem(
                  context,
                  "CPU",
                  pcProvider.selectedCPU,
                  pcProvider.cpuImage,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProcessorListScreen(),
                    ),
                  ),
                  isEnabled: true,
                  isNext: pcProvider.selectedCPU == null,
                ),
                buildSelectionItem(
                  context,
                  "Motherboard",
                  pcProvider.selectedMotherboard,
                  pcProvider.motherboardImage,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MotherboardListScreen(),
                    ),
                  ),
                  isEnabled: pcProvider.selectedCPU != null,
                  isNext:
                      pcProvider.selectedCPU != null &&
                      pcProvider.selectedMotherboard == null,
                ),
                buildSelectionItem(
                  context,
                  "Memory",
                  pcProvider.selectedRAM,
                  pcProvider.ramImage,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RAMListScreen()),
                  ),
                  isEnabled: pcProvider.selectedMotherboard != null,
                  isNext:
                      pcProvider.selectedMotherboard != null &&
                      pcProvider.selectedRAM == null,
                ),
                buildSelectionItem(
                  context,
                  "Storage",
                  pcProvider.selectedStorage,
                  pcProvider.storageImage,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HardDiskListScreen(),
                    ),
                  ),
                  isEnabled: pcProvider.selectedRAM != null,
                  isNext:
                      pcProvider.selectedRAM != null &&
                      pcProvider.selectedStorage == null,
                ),
                buildSelectionItem(
                  context,
                  "Power Supply",
                  pcProvider.selectedPowerSupply,
                  pcProvider.psuImage,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PSUListScreen()),
                  ),
                  isEnabled: pcProvider.selectedStorage != null,
                  isNext:
                      pcProvider.selectedStorage != null &&
                      pcProvider.selectedPowerSupply == null,
                ),
                buildSelectionItem(
                  context,
                  "Case",
                  pcProvider.selectedCase,
                  pcProvider.caseImage,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PCCaseListScreen()),
                  ),
                  isEnabled: pcProvider.selectedPowerSupply != null,
                  isNext:
                      pcProvider.selectedPowerSupply != null &&
                      pcProvider.selectedCase == null,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<PCProvider>().resetSelections();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text("Reset All"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSelectionItem(
    BuildContext context,
    String title,
    String? selectedItem,
    String? imageUrl,
    VoidCallback onSelect, {
    required bool isEnabled,
    required bool isNext,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
          ),
          child: Row(
            children: [
              if (imageUrl != null) ...[
                Image.network(imageUrl, width: 40, height: 40),
                SizedBox(width: 10),
              ],
              Expanded(
                child: Text(
                  selectedItem ?? title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: isEnabled ? onSelect : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedItem != null
                      ? Colors.grey
                      : isNext
                          ? Colors.green
                          : Colors.blueGrey,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  selectedItem != null
                      ? "Selected"
                      : isNext
                          ? "Select Now"
                          : "Select",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
