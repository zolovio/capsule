import 'package:get/get.dart';

import 'contact_controller.dart';

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ContactController>(ContactController());
  }
}
