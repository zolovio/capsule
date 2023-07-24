import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../../../../main.dart';
import '../../../components/custom_appbar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_navbar.dart';
import '../../../components/custom_text.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'otp_controller.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appBar: AppBar()),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: margin_20),
        children: [
          Image.asset(ImgAssets.otp),
          CustomText(
            textAlign: TextAlign.center,
            text: strOptVerify,
            fontWeight: fontWeightBold,
            fontSize: font_20,
            textColor: AppColors.pinkGrade2,
          ),
          CustomDivider(height: height_15, isDivider: false),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Enter the OTP to sent  ',
                fontWeight: fontWeight500,
                fontSize: font_11,
                textColor: AppColors.pinkGrade2,
              ),
              CustomText(
                text: controller.authRepository.phoneCode.value +
                    controller.authRepository.phoneController.value.text,
                fontWeight: fontWeight700,
                fontSize: font_11,
                textColor: AppColors.pinkGrade2,
              ),
            ],
          ),
          CustomDivider(height: height_30, isDivider: false),
          Obx(
            () => OTPTextField(
              controller: controller.otpController.value,
              length: 6,
              textFieldAlignment: MainAxisAlignment.center,
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
              style: TextStyle(
                color: AppColors.pinkGrade2,
                fontSize: font_25,
                fontWeight: fontWeight500,
                fontFamily: 'OpenSans',
              ),
              otpFieldStyle: OtpFieldStyle(
                enabledBorderColor: AppColors.pinkGrade2,
                borderColor: AppColors.pinkGrade2,
                focusBorderColor: AppColors.pinkGrade2,
              ),
              onChanged: (String pin) {
                controller.otpValue.value = pin;
              },
              onCompleted: (String pin) {},
            ),
          ),
          CustomNavBar(
            title: "Didn't you receive the OTP?",
            titleFontSize: font_11,
            titleFontWeight: fontWeight500,
            titleColor: AppColors.greyColor,
            navTitle: strResendOtp,
            navTitleFontSize: font_11,
            navTitleFontWeight: fontWeight600,
            navTitleColor: AppColors.pinkGrade2,
            padding: const EdgeInsets.only(bottom: 65),
            onTap: () {},
            bottomBarType: null,
            height: 2,
          ),
          CustomDivider(height: height_30, isDivider: false),
          Obx(
            () => CustomButton(
              title: firstLogin ? strSignup : strLogin,
              fontWeight: fontWeight600,
              fontSize: font_15,
              horizontalPadding: margin_110,
              minimumWidth: width_90,
              minimumHeight: height_35,
              radius: radius_40,
              backgroundColor: AppColors.pinkGrade2,
              textColor: AppColors.white,
              borderColor: AppColors.pinkGrade2,
              isLoading: controller.isLoading.value,
              onPressed: () => controller.handleSignup(isSignup: firstLogin),
            ),
          ),
        ],
      ),
    );
  }
}
