import 'package:get/get.dart';

import 'subject_mode_controller.dart';

class SubjectModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SubjectModeController>(SubjectModeController());
  }
}
