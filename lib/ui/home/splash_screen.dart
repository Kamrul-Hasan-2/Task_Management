import 'package:flutter/material.dart';
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
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
