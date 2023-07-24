import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

import '../../../core/configs/routes.dart';
import '../../../core/constants/palette.dart';
import '../../../core/repository/auth_repository.dart';

class OtpController extends GetxController {
  AuthRepository authRepository = Get.find();

  Rx<OtpFieldController> otpController = OtpFieldController().obs;

  RxString otpValue = ''.obs;
  RxBool isLoading = false.obs;

  handleBackNavigation() => Get.back();

  handleOtpNavigation() => Get.toNamed(AppRoutes.getOtpRoute());

  handleSignup({required bool isSignup}) async {
    isLoading.value = true;
    bool otpVerified = await authRepository.verifyOtp(otpValue.value);

    if (otpVerified == true) {
      isSignup
          ? Get.toNamed(AppRoutes.getProfileInfoRoute())
          : Get.offAndToNamed(AppRoutes.getHomeScreenRoute());
    } else {
      Get.showSnackbar(
        GetSnackBar(
          title: "WARNING!",
          message: "Something went wrong",
          icon: const Icon(Icons.warning, color: AppColors.white),
          duration: const Duration(seconds: 3),
          backgroundColor: AppColors.redColor,
        ),
      );
    }

    isLoading.value = false;
  }
}
