import 'package:get/get.dart';

import 'otp_controller.dart';

class OtpBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<OtpController>(OtpController());
  }
}
