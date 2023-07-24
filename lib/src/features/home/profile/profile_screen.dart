// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_list_tile.dart';
import '../../../components/custom_percent_indicator.dart';
import '../../../components/custom_shaded_text.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        appBar: AppBar(),
        text: strMyAccount,
        fontWeight: fontWeight600,
        fontSize: font_20,
        textColor: AppColors.pinkGrade2,
        isEmptyTitle: false,
        isLeading: true,
        isCenter: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_35),
        children: [
          CustomPercentIndicator(
            radius: radius_60,
            lineWidth: width_5,
            percent: 0.8,
            reverse: true,
            startAngle: 70,
            animation: false,
            animationDuration: 1000,
            animateFromLastPercent: false,
            progressColor: AppColors.pinkGrade2,
            backgroundColor: AppColors.pinkGrade2.withOpacity(0.2),
            image: ImgAssets.userProf1,
            isProfile: true,
          ),
          CustomDivider(height: height_10, isDivider: false),
          CustomShadedText(
            text: "Hello, Danish",
            fontWeight: fontWeight600,
            fontSize: font_18,
            textColor: AppColors.pinkGrade2,
            textAlignment: TextAlign.center,
          ),
          CustomDivider(height: height_15, isDivider: false),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor.withOpacity(.6),
                  offset: const Offset(0, 5),
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius_20),
              ),
              child: Column(
                children: controller.profile
                    .map<Widget>(
                      (data) => CustomListTile(
                        elevation: 0,
                        margin: margin_1,
                        tileColor: AppColors.white,
                        radius: radius_15,
                        image: data["icon"],
                        imageColor: AppColors.pinkGrade2,
                        containerColor: AppColors.pinkFillColor,
                        containerPadding: margin_10,
                        titleText: data["title"],
                        titleFontWeight: fontWeight600,
                        titleFontSize: font_14,
                        titleTextColor: AppColors.black,
                        subtitleText: data["subtitle"],
                        subtitleFontWeight: fontWeight400,
                        subtitleFontSize: font_11,
                        subtitleTextColor: AppColors.greyColor,
                        icon: Icons.keyboard_arrow_right,
                        iconColor: AppColors.pinkGrade2,
                        onTap: data["title"] == "Log out"
                            ? controller.showAlert
                            : data["title"] == "My Account"
                                ? controller.setProfileEditing
                                : () => controller.handleNavigation(data["nav"]),
                        isListOnly: true,
                        isIndicator: false,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
