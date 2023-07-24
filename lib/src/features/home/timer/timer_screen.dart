import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_percent_indicator.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import 'timer_controller.dart';

class TimerScreen extends GetView<TimerController> {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Center(
          child: CustomPercentIndicator(
            animation: false,
            animationDuration: 1000,
            startAngle: 0,
            radius: radius_120,
            lineWidth: width_5,
            percent: controller.myDuration.value.inSeconds / 5,
            reverse: true,
            animateFromLastPercent: false,
            progressColor: AppColors.pinkGrade2,
            backgroundColor: AppColors.blueGrade2,
            text: controller.myDuration.value.inSeconds.toString(),
            fontWeight: fontWeightBold,
            fontSize: font_140,
            textColor: AppColors.pinkGrade2,
          ),
        ),
      ),
    );
  }
}
