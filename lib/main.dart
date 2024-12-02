import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:passport_to_the_north/pages/user_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures binding for async code
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(), // Replace with your login page class
    );
  }
}
