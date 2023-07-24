import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_circle_avatar.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_icon.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'score_board_controller.dart';

class ScoreBoardScreen extends GetView<ScoreBoardController> {
  const ScoreBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.testScore == null
                ? const Center(
                    child: Text('No data found'),
                  )
                : ListView(
                    padding: EdgeInsets.only(top: margin_120, left: margin_20, right: margin_20),
                    children: [
                      CustomCircleAvatar(
                        radius: radius_100,
                        radius1: radius_85,
                        radius2: radius_70,
                        backgroundColor: AppColors.pinkGrade2,
                        backgroundColor1: AppColors.pinkGrade3,
                        backgroundColor2: AppColors.white,
                        titleText: strTotalScore,
                        titleFontWeight: fontWeight600,
                        titleFontSize: font_14,
                        titleColor: AppColors.pinkGrade2,
                        scoreText: "${controller.testScore!.rightAnswers!}",
                        scoreFontWeight: fontWeight600,
                        scoreFontSize: font_40,
                        scoreColor: AppColors.pinkGrade2,
                        subTitleText: "Out of ${controller.testScore!.totalQuestionNo}",
                        subTitleFontWeight: fontWeight600,
                        subTitleFontSize: font_11,
                        subTitleColor: AppColors.pinkGrade2,
                        height: height_8,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: margin_50),
                        padding: EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_5),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomContainer(
                                  radius: radius_5,
                                  containerColor: AppColors.pinkGrade2,
                                  text:
                                      "${controller.testScore!.correctPercentage!.toStringAsFixed(controller.testScore!.complete! % 1 == 0 ? 0 : 1)}%",
                                  fontWeight: fontWeight700,
                                  fontSize: font_15,
                                  textColor: AppColors.pinkGrade2,
                                  subText: strCompletion,
                                  subFontWeight: fontWeight600,
                                  subFontSize: font_10,
                                  subTextColor: AppColors.greyColor,
                                  paddingHorizontal: margin_15,
                                  paddingVertical: margin_15,
                                  width: width_10,
                                  height: height_5,
                                  isResult: true,
                                ),
                                CustomContainer(
                                  radius: radius_5,
                                  containerColor: AppColors.pinkGrade2,
                                  text: controller.testScore!.rightAnswers! < 10 &&
                                          controller.testScore!.rightAnswers! > 0
                                      ? "0${controller.testScore!.rightAnswers}"
                                      : "${controller.testScore!.rightAnswers}",
                                  fontWeight: fontWeight700,
                                  fontSize: font_15,
                                  textColor: AppColors.pinkGrade2,
                                  subText: strCorrect,
                                  subFontWeight: fontWeight600,
                                  subFontSize: font_10,
                                  subTextColor: AppColors.greyColor,
                                  paddingHorizontal: margin_15,
                                  paddingVertical: margin_15,
                                  width: width_10,
                                  height: height_5,
                                  isResult: true,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomContainer(
                                  radius: radius_5,
                                  containerColor: AppColors.blueGrade2,
                                  text: controller.testScore!.totalQuestionNo! < 10
                                      ? "0${controller.testScore!.totalQuestionNo}"
                                      : "${controller.testScore!.totalQuestionNo}",
                                  fontWeight: fontWeight700,
                                  fontSize: font_15,
                                  textColor: AppColors.blueGrade2,
                                  subText: strNumOfQues,
                                  subFontWeight: fontWeight600,
                                  subFontSize: font_10,
                                  subTextColor: AppColors.greyColor,
                                  paddingHorizontal: margin_15,
                                  paddingVertical: margin_15,
                                  width: width_10,
                                  height: height_5,
                                  isResult: true,
                                ),
                                CustomContainer(
                                  radius: radius_5,
                                  containerColor: AppColors.blueGrade2,
                                  text: controller.testScore!.wrongAnswers! < 10
                                      ? "0${controller.testScore!.wrongAnswers}"
                                      : "${controller.testScore!.wrongAnswers}",
                                  fontWeight: fontWeight700,
                                  fontSize: font_15,
                                  textColor: AppColors.blueGrade2,
                                  subText: strWrong,
                                  subFontWeight: fontWeight600,
                                  subFontSize: font_10,
                                  subTextColor: AppColors.greyColor,
                                  paddingHorizontal: margin_15,
                                  paddingVertical: margin_15,
                                  width: width_10,
                                  height: height_5,
                                  isResult: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin_25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: CustomIcon(
                                image: ImgAssets.eye,
                                imageColor: AppColors.white,
                                containerColor: AppColors.pinkGrade2,
                                margin: margin_10,
                                text: strReviewAnswer,
                                fontWeight: fontWeight600,
                                fontSize: font_12,
                                textColor: AppColors.black,
                                onPressed: controller.handleReviewNavigation,
                              ),
                            ),
                            Expanded(
                              child: CustomIcon(
                                image: ImgAssets.share,
                                imageColor: AppColors.white,
                                containerColor: AppColors.pinkGrade2,
                                margin: margin_10,
                                text: strShare,
                                fontWeight: fontWeight600,
                                fontSize: font_12,
                                textColor: AppColors.black,
                                onPressed: null,
                              ),
                            ),
                            Expanded(
                              child: CustomIcon(
                                image: ImgAssets.home,
                                imageColor: AppColors.white,
                                containerColor: AppColors.pinkGrade2,
                                margin: margin_10,
                                text: strHome,
                                fontWeight: fontWeight600,
                                fontSize: font_12,
                                textColor: AppColors.black,
                                onPressed: controller.handleHomeRoute,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
      ),
    );
  }
}
