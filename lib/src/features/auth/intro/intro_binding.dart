import 'package:get/get.dart';

import 'intro_controller.dart';

class IntroBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IntroController>(IntroController());
  }
}
