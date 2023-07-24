// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_shaded_text.dart';
import '../../../components/custom_text.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'intro_controller.dart';

class IntroScreen extends GetView<IntroController> {
  IntroScreen({Key? key}) : super(key: key);

  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.white,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: PageView.builder(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: 2,
          onPageChanged: (page) {},
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: margin_20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (index == 0) ...[
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomShadedText(
                            text: "Learn anywhere &",
                            textColor: AppColors.white,
                            fontSize: font_28,
                            fontWeight: fontWeight400,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomShadedText(
                            text: "Anytime",
                            textColor: AppColors.white,
                            fontSize: font_28,
                            fontWeight: fontWeightBold,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(ImgAssets.signUp),
                  ],
                  if (index == 1) ...[
                    Image.asset(ImgAssets.signUp),
                    Column(
                      children: [
                        SizedBox(height: height_10),
                        CustomText(
                          text: "The learning app to read and revise NCERT in the smartest way",
                          fontWeight: fontWeight600,
                          fontSize: font_15,
                          textColor: AppColors.black,
                          height: 1.5,
                        ),
                        SizedBox(height: height_20),
                        CustomText(
                          text: "- Chapterwise and Topicwise question bank \n"
                              "- Questions are purely based on NCERT \n"
                              "- Answers provided with NCERT page number \n"
                              "- Mnemonics included \n"
                              "- Full length previous year papers \n",
                          fontWeight: fontWeight400,
                          fontSize: font_14,
                          textColor: AppColors.black,
                          height: 1.5,
                        ),
                      ],
                    ),
                  ],
                  Padding(
                    padding: EdgeInsets.only(bottom: margin_100),
                    child: CustomButton(
                      title: strContinue,
                      fontWeight: fontWeight600,
                      fontSize: font_18,
                      horizontalPadding: margin_60,
                      minimumWidth: width_150,
                      minimumHeight: height_45,
                      radius: radius_40,
                      backgroundColor: AppColors.blueGrade2,
                      textColor: AppColors.white,
                      borderColor: AppColors.blueGrade2,
                      onPressed: () => (index == 0)
                          ? pageController.jumpToPage(index + 1)
                          : controller.onTabChangeCompleted(index + 1),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
