import 'package:get/get.dart';

import 'test_set_controller.dart';

class TestSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TestSetController>(TestSetController());
  }
}
