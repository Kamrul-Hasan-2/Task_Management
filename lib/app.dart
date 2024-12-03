import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/controller_binder.dart';
import 'ui/home/splash_screen.dart';

class TaskManagement extends StatelessWidget {
  const TaskManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData()
      ),
      initialBinding: ControllerBinder(),
      home: const SplashScreen(),
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData(){
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color(0xFF2491EB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );
  }

  InputDecorationTheme _inputDecorationTheme(){
    return InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

}
