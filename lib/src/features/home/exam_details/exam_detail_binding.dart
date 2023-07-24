import 'package:get/get.dart';

import 'exam_detail_controller.dart';

class ExamDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ExamDetailController>(ExamDetailController());
  }
}
