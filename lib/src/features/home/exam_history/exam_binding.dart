import 'package:get/get.dart';

import 'exam_controller.dart';

class ExamsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ExamsController>(ExamsController());
  }
}
