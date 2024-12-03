import 'package:get/get.dart';
import 'package:task_management/data/model/network_respose.dart';
import 'package:task_management/data/service/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/controller/auth_controller.dart';

class LoginController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool get inProgress => _inProgress;

  Future<bool> login(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.login,
      body: requestBody,
    );

    if (response.isSuccess) {
      final String token = response.responseData['token'] ?? " ";
      await AuthController.saveAccessToken(token);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
