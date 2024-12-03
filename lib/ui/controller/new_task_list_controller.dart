import 'package:get/get.dart';
import 'package:task_management/data/model/network_respose.dart';
import 'package:task_management/data/model/task_list_model.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/data/service/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';


class NewTaskListController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<TaskModel> _taskList = [];

  List<TaskModel> get taskList => _taskList;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.getTask);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);
      _taskList = taskListModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }

  Future<bool> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller.deleteRequest(url: Urls.deleteTask(taskId));
    if (response.isSuccess) {
      _taskList.removeWhere((task) => task.sId == taskId);
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
    return response.isSuccess;
  }

}