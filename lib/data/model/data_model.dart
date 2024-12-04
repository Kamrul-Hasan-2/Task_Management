import 'package:task_management/data/model/user_data.dart';

class DataModel {
  String? status;
  String? message;
  UserData? data;

  DataModel({this.status, this.message, this.data});

  DataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  UserData.fromJson(json['data']) : null;
  }
}
