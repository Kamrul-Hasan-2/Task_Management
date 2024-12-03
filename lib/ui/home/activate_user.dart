import 'package:flutter/material.dart';

class ActivateUserScreen extends StatefulWidget {
  const ActivateUserScreen({super.key});

  @override
  State<ActivateUserScreen> createState() => _ActivateUserScreenState();
}

class _ActivateUserScreenState extends State<ActivateUserScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activate User'),
        backgroundColor: const Color(0xFF2491EB),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Activate Your Account",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2491EB),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Activation Code',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Activation button pressed!")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2491EB),
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                'Activate',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
