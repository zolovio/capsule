import 'package:get/get.dart';

import '../../../core/configs/routes.dart';

class SubjectDetailsController extends GetxController {
  void handleBackNavigation() => Get.back();

  void handleForwardNavigation() => Get.toNamed(AppRoutes.getTimerRoute());
}
