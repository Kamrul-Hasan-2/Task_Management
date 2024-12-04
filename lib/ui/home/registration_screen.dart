import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/home/login_screen.dart';
import 'package:task_management/ui/controller/registration_controller.dart';
import 'package:task_management/ui/widget/snack_bar_message.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();

  final RegistrationController _registrationController = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2491EB),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Create an account to get started.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      _buildRegistrationFormSection(),
                      const SizedBox(height: 24),
                      GetBuilder<RegistrationController>(builder: (controller) {
                        return Visibility(
                          visible: !controller.inProgress,
                          replacement: const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                            onPressed: _moveToLoginScreen,
                            child: const Text(
                              "Sign up",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.off(const LoginScreen());
                            },
                            child: const Text(
                              "Log in",
                              style: TextStyle(color: Color(0xFF2491EB)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildRegistrationFormSection() {
    return Column(
      children: [
        TextFormField(
          controller: _firstNameTEController,
          decoration: const InputDecoration(
            labelText: 'First Name',
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'First Name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _lastNameTEController,
          decoration: const InputDecoration(
            labelText: 'Last Name',
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Last Name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailTEController,
          decoration: const InputDecoration(
            labelText: 'Email',
          ),
          keyboardType: TextInputType.emailAddress,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Email is required';
            }
            if (!value!.contains('@')) {
              return 'Enter a valid Email "@"';
            }
            if (!value.contains('.com')) {
              return 'Enter a valid Email ".com"';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _passwordTEController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Password is required';
            }
            if (value!.length <= 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _addressTEController,
          decoration: const InputDecoration(
            labelText: 'Address',
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Address is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _moveToLoginScreen() {
    if (_formKey.currentState!.validate()) {
      _register();
    }
  }

  Future<void> _register() async {
    final bool result = await _registrationController.registration(
      _firstNameTEController.text.trim(),
      _lastNameTEController.text.trim(),
      _emailTEController.text.trim(),
      _passwordTEController.text,
      _addressTEController.text.trim(),
    );

    if (result) {
      Get.offAll(const LoginScreen());  // Redirect to login screen on successful registration
    } else {
      _clear();
      snackBarMessage(context, _registrationController.errorMessage!, true);
    }
  }

  void _clear(){
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _emailTEController.clear();
    _passwordTEController.clear();
    _addressTEController.clear();
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _addressTEController.dispose();
    super.dispose();
  }
}
