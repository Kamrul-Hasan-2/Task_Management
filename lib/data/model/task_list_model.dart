import 'package:task_management/data/model/task_model.dart';

class TaskListModel {
  String? status;
  List<TaskModel>? taskList;

  TaskListModel({this.status, this.taskList});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskModel>[];
      json['data']['myTasks'].forEach((v) {
        taskList!.add(TaskModel.fromJson(v));
      });
    }
  }
}