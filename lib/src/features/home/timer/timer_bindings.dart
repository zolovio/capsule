import 'package:get/get.dart';

import 'timer_controller.dart';

class TimerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TimerController>(TimerController());
  }
}
