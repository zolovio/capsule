import 'package:get/get.dart';

import 'profile_info_controller.dart';

class ProfileInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ProfileInfoController>(ProfileInfoController());
  }
}
