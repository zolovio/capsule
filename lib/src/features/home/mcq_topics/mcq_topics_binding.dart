import 'package:get/get.dart';

import 'mcq_topics_controller.dart';

class McqTopicsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<McqTopicController>(McqTopicController());
  }
}
