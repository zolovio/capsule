import 'dart:async';

import 'package:get/get.dart';

import '../../../core/configs/routes.dart';

class TimerController extends GetxController {
  Timer? countdownTimer;
  Rx<Duration> myDuration = const Duration(seconds: 5).obs;

  @override
  void onInit() {
    startTimer();

    super.onInit();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;

    final seconds = myDuration.value.inSeconds - reduceSecondsBy;

    if (seconds < 0) {
      countdownTimer!.cancel();

      Get.offAndToNamed(AppRoutes.getQuizRoute());
    } else {
      myDuration.value = Duration(seconds: seconds);
    }
  }
}
