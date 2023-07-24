import 'package:capsule_new/src/features/auth/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_navbar.dart';
import '../../../components/custom_phone_input.dart';
import '../../../components/custom_shaded_text.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appBar: AppBar()),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: margin_20),
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: CustomShadedText(
              text: "Log in to your",
              textColor: AppColors.white,
              fontSize: font_28,
              fontWeight: fontWeightBold,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: CustomShadedText(
              text: "Account",
              textColor: AppColors.white,
              fontSize: font_28,
              fontWeight: fontWeightBold,
            ),
          ),
          CustomDivider(height: height_30, isDivider: false),
          Image.asset(ImgAssets.logIn),
          CustomDivider(height: height_30, isDivider: false),
          FormBuilder(
            onChanged: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: margin_20),
              child: CustomPhoneInput(
                name: 'phone',
                labelText: strMobile,
                labelColor: AppColors.pinkGrade2,
                fontSize: font_12,
                fontWeight: fontWeight400,
                radius: radius_10,
                fillColor: AppColors.pinkFillColor,
                borderColor: AppColors.pinkGrade2,
                borderWidth: width_1,
                flagsPadding: margin_10,
                onCountryChanged: (country) {
                }, countryCode: 'Ind',
              ),
            ),
          ),
          CustomDivider(height: height_30, isDivider: false),
          Obx(
            () => CustomButton(
              title: strGetOtp,
              fontWeight: fontWeight600,
              fontSize: font_15,
              horizontalPadding: margin_90,
              minimumWidth: width_90,
              minimumHeight: height_40,
              radius: radius_40,
              backgroundColor: AppColors.pinkGrade2,
              textColor: AppColors.white,
              borderColor: AppColors.pinkGrade2,
              isLoading: false,
              onPressed: () {}
            ),
          ),
          CustomDivider(height: height_25, isDivider: false),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: margin_15),
            child: CustomDivider(
              height: height_31,
              text: strContinueWith,
              color: AppColors.black.withOpacity(0.5),
              isDivider: true,
            ),
          ),
          CustomDivider(height: height_25, isDivider: false),
          CustomButton(
            title: strGoogleSignIn,
            icon: Image.asset(ImgAssets.google, height: height_20),
            fontWeight: fontWeight500,
            fontSize: font_15,
            radius: radius_10,
            backgroundColor: AppColors.white,
            minimumHeight: height_48,
            textColor: AppColors.black,
            borderColor: AppColors.greyColor,
            onPressed: () {},
            horizontalPadding: margin_15,
            minimumWidth: width_150,
          ),
          CustomDivider(height: height_30, isDivider: false),
          CustomNavBar(
            title: strAccountExist,
            titleFontSize: font_14,
            titleFontWeight: fontWeight400,
            titleColor: AppColors.black,
            navTitle: strSignup,
            navTitleFontSize: font_14,
            navTitleFontWeight: fontWeight600,
            navTitleColor: AppColors.pinkGrade2,
            onTap: controller.handleLoginNavigation,
            bottomBarType: BottomBarType.simple,
            height: height_50,
            padding: EdgeInsets.all(margin_20),
          ),
        ],
      ),
    );
  }
}
