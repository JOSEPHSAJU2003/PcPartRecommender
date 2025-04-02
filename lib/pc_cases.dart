import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'pc_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://mvqkpqeydbunjhzdjmfb.supabase.co',
    anonKey: 'your-anon-key-here',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PCProvider(),
      child: MaterialApp(
        home: PCCaseListScreen(),
      ),
    );
  }
}

class PCCaseListScreen extends StatefulWidget {
  @override
  _PCCaseListScreenState createState() => _PCCaseListScreenState();
}

class _PCCaseListScreenState extends State<PCCaseListScreen> {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<dynamic>> fetchCases() async {
    final String? formFactor = Provider.of<PCProvider>(context, listen: false).formfactor;
  // Mapping motherboard form factors to compatible case types
  final Map<String, List<String>> formFactorToCases = {
    'EATX': ['ATX Full Tower'],  
    'ATX': ['ATX Full Tower', 'ATX Mid Tower'],
    'MicroATX': ['ATX Full Tower', 'ATX Mid Tower', 'Micro ATX Mid Tower', 'Micro ATX Mini Tower', 'Micro ATX Desktop'],
    'Mini ITX': ['ATX Full Tower', 'ATX Mid Tower', 'Micro ATX Mid Tower', 'Micro ATX Mini Tower', 'Micro ATX Desktop', 'Mini ITX Desktop'],
  };

  // Get compatible case types for the selected motherboard form factor
  final compatibleCases = formFactorToCases[formFactor] ?? [];

  if (compatibleCases.isEmpty) return []; // Return empty list if no cases match

  // Build OR filter for Supabase query
  String orFilter = compatibleCases.map((type) => 'type.eq.$type').join(',');

  // Fetch cases that match the compatible types
  final response = await supabase
      .from('pc_cases')
      .select()
      .or(orFilter);
    return response;
  }

  void _onCaseSelected(BuildContext context, Map<String, dynamic> pcCase) {
    context.read<PCProvider>().updateCase(
      pcCase['name'],
      pcCase['image_url'] ?? 'https://via.placeholder.com/150',
    );
    print("Selected Case: ${pcCase['name']}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PC Cases')),
      body: FutureBuilder(
        future: fetchCases(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cases found'));
          }

          final cases = snapshot.data as List<dynamic>;
          
          return ListView.builder(
            itemCount: cases.length,
            itemBuilder: (context, index) {
              final pcCase = cases[index];
              return Card(
                child: ListTile(
                  leading: pcCase['image_url'] != null
                      ? Image.network(pcCase['image_url'], width: 50, height: 50, fit: BoxFit.cover)
                      : Icon(Icons.computer),
                  title: Text(pcCase['name']),
                  subtitle: Text(
                    'Type: ${pcCase['type']}\n'
                    'Color: ${pcCase['color']}'
                    '\nPrice: \$${pcCase['price']}'
                    '\nSide Panel: ${pcCase['side_panel']}'
                    '\nExternal Volume: ${pcCase['external_volume']}L'
                  ),
                  onTap: () => _onCaseSelected(context, pcCase),
                ),
              );
            },
          );
        },
      ),
    );
  }
}