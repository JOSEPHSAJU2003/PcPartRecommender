import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SavedBuildsPage extends StatefulWidget {
  final String userId;  // Changed to String as Supabase uses UUID

  SavedBuildsPage({required this.userId});

  @override
  _SavedBuildsPageState createState() => _SavedBuildsPageState();
}

class _SavedBuildsPageState extends State<SavedBuildsPage> {
  final supabase = Supabase.instance.client;
  final Color primaryColor = Color(0xFF22052D); // Deep purple
  final Color accentColor = Color(0xFFCD7D1B);  // Orange

  Future<List<Map<String, dynamic>>> getUserBuilds() async {
    final response = await supabase
        .from('saved_builds')
        .select()
        .eq('user_id', widget.userId)
        .order('created_at', ascending: false);
    
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Saved Builds'),
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getUserBuilds(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            ));
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(
              'No saved builds yet',
              style: TextStyle(fontSize: 18, color: primaryColor),
            ));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final build = snapshot.data![index];
              return Card(
                margin: EdgeInsets.all(8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: primaryColor.withOpacity(0.3), width: 1),
                ),
                child: ExpansionTile(
                  title: Text(
                    build['build_name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  subtitle: Text(
                    'Created: ${DateTime.parse(build['created_at']).toString().split('.')[0]}',
                    style: TextStyle(color: primaryColor.withOpacity(0.7)),
                  ),
                  iconColor: accentColor,
                  collapsedIconColor: accentColor,
                  children: [
                    ListTile(title: Text('Processor: ${build['processor']}')),
                    ListTile(title: Text('Cooling: ${build['cooling']}')),
                    ListTile(title: Text('GPU: ${build['gpu']}')),
                    ListTile(title: Text('RAM: ${build['ram']}')),
                    ListTile(title: Text('Storage: ${build['storage']}')),
                    ListTile(title: Text('PSU: ${build['psu']}')),
                    ListTile(title: Text('Motherboard: ${build['motherboard']}')),
                    ListTile(title: Text('Category: ${build['category']}')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await supabase
                                .from('saved_builds')
                                .delete()
                                .eq('id', build['id']);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}