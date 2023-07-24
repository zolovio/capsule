import 'package:get/get.dart';

import 'quiz_controller.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<QuizController>(QuizController(), permanent: true);
  }
}
