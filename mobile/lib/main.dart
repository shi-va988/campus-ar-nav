import 'package:flutter/material.dart';
import 'package:campus_ar_mobile/screens/home_screen.dart';

void main() {
  runApp(const CampusArApp());
}

class CampusArApp extends StatelessWidget {
  const CampusArApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus AR Nav',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}
