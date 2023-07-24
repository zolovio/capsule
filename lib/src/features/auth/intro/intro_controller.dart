import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../core/configs/routes.dart';

class IntroController extends GetxController {
  RxBool firstLogin = false.obs;

  void onTabChangeCompleted(index) {
    preferences.setBool("firstLogin", false);

    Get.toNamed(AppRoutes.getSignupRoute());
  }
}
