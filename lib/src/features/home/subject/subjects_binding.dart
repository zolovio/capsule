import 'package:get/get.dart';

import 'subjects_controller.dart';

class SubjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SubjectsController>(SubjectsController(), permanent: true);
  }
}
