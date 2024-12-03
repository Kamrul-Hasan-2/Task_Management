import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/controller/login_controller.dart';
import 'package:task_management/ui/home/home_screen.dart';
import 'package:task_management/ui/home/registration_screen.dart';
import 'package:task_management/ui/widget/centred_circular_progress_indicator.dart';
import 'package:task_management/ui/widget/snack_bar_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final LoginController _loginController = Get.put(LoginController());

  static const Color themeColor = Color(0xFF2491EB);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          // Header Section
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/login.png', // Replace with your asset
                  height: 550,
                  width: 400,
                ),
              ),
            ),
          ),

          // Login Form Section
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Login Title
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Sign in to continue.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),

                      // Login Form Fields
                      _buildLoginFormSection(),
                      const SizedBox(height: 24),

                      // Login Button
                      GetBuilder<LoginController>(
                        builder: (controller) {
                          return Visibility(
                            visible: !controller.inProgress,
                            replacement: const CentreCircularProgressIndicator(),
                            child: ElevatedButton(
                              onPressed: _logIn,
                              child: const Text(
                                "Log in",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),

                      // Signup Section
                      _buildSignUpSection(themeColor),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginFormSection() {
    return Column(
      children: [
        TextFormField(
          controller: _userNameTEController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            labelText: 'Username',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your username';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _passwordTEController,
          obscureText: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSignUpSection(Color themeColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account?',
          style: TextStyle(color: Colors.grey),
        ),
        TextButton(
          onPressed: () {
            Get.to(() => const RegistrationScreen());
          },
          child: Text(
            "Sign Up!",
            style: TextStyle(color: themeColor),
          ),
        ),
      ],
    );
  }

  Future<void> _logIn() async {
    if (_formKey.currentState!.validate()) {
      final bool result = await _loginController.login(
        _userNameTEController.text.trim(),
        _passwordTEController.text.trim(),
      );

      if (result) {
        snackBarMessage(context, 'Login Successful');
        Get.to(const HomeScreen());
        // Navigate to the next screen if needed
      } else {
        snackBarMessage(context, _loginController.errorMessage ?? 'Login Failed',
             true);
      }
    }
  }

  @override
  void dispose() {
    _userNameTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
