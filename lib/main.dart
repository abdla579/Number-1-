import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MobileRepairApp());
}

class MobileRepairApp extends StatelessWidget {
  const MobileRepairApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'صيانة الموبايل',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
