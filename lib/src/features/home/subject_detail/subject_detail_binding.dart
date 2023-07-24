import 'package:get/get.dart';

import 'subject_detail_controller.dart';

class SubjectDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SubjectDetailsController>(SubjectDetailsController());
  }
}
