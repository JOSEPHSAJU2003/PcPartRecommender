import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pc_provider.dart';
import 'background_image_screen.dart';
import 'auth/login_page.dart';
import 'auth/signup_page.dart';
import 'models/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://mvqkpqeydbunjhzdjmfb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im12cWtwcWV5ZGJ1bmpoemRqbWZiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyNzExNTQsImV4cCI6MjA1NDg0NzE1NH0.ezKO9vkplX6kgDhq2aSbderrcuDcfakmI5vBrsUT3JU',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PCProvider()),
        // Add other providers here if needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PC Part Recommender',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
