import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_shaded_text.dart';
import '../../../components/custom_text.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'subject_detail_controller.dart';

class SubjectDetailsScreen extends GetView<SubjectDetailsController> {
  const SubjectDetailsScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        appBar: AppBar(),
        text: title,
        fontWeight: fontWeight600,
        fontSize: font_20,
        textColor: AppColors.pinkGrade2,
        image: ImgAssets.heart,
        imageColor: AppColors.white,
        containerColor: AppColors.pinkGrade2,
        margin: margin_6,
        isEmptyTitle: false,
      ),
      body: ListView(
        children: [
          Image.asset(ImgAssets.subDetail),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height_10),
                CustomShadedText(
                  text: "IMPORTANT NOTES",
                  textAlignment: TextAlign.start,
                  textColor: AppColors.white,
                  fontSize: font_20,
                  fontWeight: fontWeight700,
                ),
                SizedBox(height: height_20),
                CustomText(
                  text: "1. Chapterwise and Topicwise question bank \n"
                      "2. Questions are purely based on NCERT \n"
                      "3. Answers provided with NCERT page number \n"
                      "4. Mnemonics included \n"
                      "5. Full length previous year papers \n",
                  fontWeight: fontWeight400,
                  fontSize: font_14,
                  textColor: AppColors.black,
                  height: 2,
                  maxLines: 10,
                ),
                CustomDivider(height: height_12),
                Center(
                  child: CustomButton(
                    title: strStartQuiz,
                    fontWeight: fontWeight600,
                    fontSize: font_16,
                    horizontalPadding: margin_0,
                    minimumWidth: width_120,
                    minimumHeight: height_35,
                    radius: radius_40,
                    backgroundColor: AppColors.pinkGrade2,
                    textColor: AppColors.white,
                    borderColor: AppColors.pinkGrade2,
                    onPressed: controller.handleForwardNavigation,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
