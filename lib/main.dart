import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'blood_pressure_screen.dart';

void main() {
  runApp(const BloodPressureApp());
}

class BloodPressureApp extends StatelessWidget {
  const BloodPressureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Pressure App',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 113, 6, 184),
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 113, 6, 184),
        ),
      ),
      home: BloodPressureScreen(),
    );
  }
}
