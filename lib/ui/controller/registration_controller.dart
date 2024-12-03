import 'package:get/get.dart';
import 'package:task_management/data/model/network_respose.dart';
import 'package:task_management/data/service/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';

class RegistrationController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool get inProgress => _inProgress;

  Future<bool> registration(String firstName, String lastName, String email,
      String password, String address) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, String> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "address" : address
    };

    NetworkResponse response = await NetworkCaller.postStreamRequest(
      url: Urls.registration,
      body: requestBody,
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
