import 'package:get/get.dart';
import 'package:task_management/data/model/network_respose.dart';
import 'package:task_management/data/service/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';

class AddNewTaskController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> adNewTask(String title, String description) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTask, body: requestBody,);

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