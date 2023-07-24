import 'package:get/get.dart';

import 'signup_controller.dart';

class SignupBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SignupController>(SignupController());
  }
}
