import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management/data/model/user_data.dart';
import 'package:task_management/data/service/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/controller/auth_controller.dart';
import 'package:task_management/ui/controller/profile_controller.dart';
import 'package:task_management/ui/widget/snack_bar_message.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _updateProfileInProgress = false;
  XFile? _selectedImage;

  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  void _setUserData() {
    final profileController = Get.find<ProfileController>();
    // Pre-fill the form with user data from AuthController
    _emailTEController.text = profileController.userData?.email ?? '';
    _firstNameTEController.text = profileController.userData?.firstName ?? '';
    _lastNameTEController.text = profileController.userData?.lastName ?? '';
    _addressTEController.text = profileController.userData?.lastName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: _updateProfileInProgress
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: _buildPhotoPicker()),
                const SizedBox(height: 20),
                _buildTextFormField(
                  controller: _emailTEController,
                  label: 'Email',
                  enabled: false,
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  controller: _firstNameTEController,
                  label: 'First Name',
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  controller: _lastNameTEController,
                  label: 'Last Name',
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  controller: _addressTEController,
                  label: 'Address',
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  controller: _passwordTEController,
                  label: 'Password (optional)',
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _updateProfile,
                  icon: const Icon(Icons.save),
                  label: const Text('Update Profile'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    String? Function(String?)? validator,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      obscureText: obscureText,
      validator: validator,
      enabled: enabled,
    );
  }

  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 60,
        backgroundImage:
        _selectedImage != null ? FileImage(File(_selectedImage!.path)) : null,
        child: _selectedImage == null
            ? const Icon(Icons.camera_alt, size: 40)
            : null,
      ),
    );
  }

  Future<void> _pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _updateProfileInProgress = true;
    });

    try {
      Map<String, String> requestBody = {
        "email": _emailTEController.text,
        "firstName": _firstNameTEController.text,
        "lastName": _lastNameTEController.text,
        "mobile": _addressTEController.text,
      };

      if (_passwordTEController.text.isNotEmpty) {
        requestBody['password'] = _passwordTEController.text;
      }

      if (_selectedImage != null) {
        List<int> imageBytes = await _selectedImage!.readAsBytes();
        requestBody['photo'] = base64Encode(imageBytes);
      }
      Map<String, String>? files;
      if (_selectedImage != null) {
        files = {'file': _selectedImage!.path};
      }

      final response = await NetworkCaller.patchStreamRequest(
        url: Urls.userProfile,
        body: requestBody,
        files: files,
      );

      if (response.isSuccess) {
        snackBarMessage(context, 'Profile updated successfully!');
        profileController.setUserData(UserData.fromJson(response.responseData['data']));
      } else {
        snackBarMessage(context, response.errorMessage, true);
      }
    } catch (e) {
      snackBarMessage(context, 'An error occurred: $e', true);
    } finally {
      setState(() {
        _updateProfileInProgress = false;
      });
    }
  }

}
