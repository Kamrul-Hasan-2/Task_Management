import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/controller/auth_controller.dart';
import 'package:task_management/ui/home/home_screen.dart';
import 'package:task_management/ui/home/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _nextScreenMove();
    super.initState();
  }

  Future<void> _nextScreenMove() async {
    await Future.delayed(const Duration(seconds: 3));
    await AuthController.getAccessToken();
    if(AuthController.isLoggedIn()){
      Get.off(const HomeScreen());
    }else{
      Get.off(const LoginScreen());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/bdCalling.png'),
          ],
        ),
      ),
    );
  }
}
