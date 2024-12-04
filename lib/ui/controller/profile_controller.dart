import 'package:get/get.dart';

import '../../data/model/user_data.dart';

class ProfileController extends GetxController {
  UserData? _userData;
  UserData? get userData => _userData;

  setUserData(UserData data) {
    _userData = data;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}

