import 'package:get/get.dart';
import 'package:task_management/ui/controller/add_new_task_controller.dart';
import 'package:task_management/ui/controller/login_controller.dart';
import 'package:task_management/ui/controller/registration_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(RegistrationController());
    Get.put(AddNewTaskController());
  }
}