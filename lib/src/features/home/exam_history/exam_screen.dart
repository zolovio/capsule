// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_list_tile.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'exam_controller.dart';

class ExamsScreen extends StatelessWidget {
  ExamsScreen({Key? key}) : super(key: key);

  ExamsController controller = Get.put(ExamsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        appBar: AppBar(),
        text: strViewMcqHistory,
        fontWeight: fontWeight600,
        fontSize: font_20,
        textColor: AppColors.pinkGrade2,
        isEmptyTitle: false,
        isLeading: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_15),
        children: controller.examHistory.map<Widget>(
          (result) {
            Color color = (controller.examHistory.indexOf(result) + 1) % 2 == 0
                ? AppColors.pinkGrade2
                : AppColors.blueGrade2;

            return Padding(
              padding: EdgeInsets.symmetric(vertical: margin_8),
              child: CustomListTile(
                margin: margin_5,
                tileColor: color,
                radius: radius_15,
                avatarColor: AppColors.white,
                leadingText: (controller.examHistory.indexOf(result) + 1).toString(),
                leadingFontWeight: fontWeight700,
                leadingFontSize: font_16,
                leadingTextColor: AppColors.black,
                titleText: result.chapterName!,
                titleFontWeight: fontWeight700,
                titleFontSize: font_14,
                titleTextColor: AppColors.white,
                lineHeight: height_5,
                percent: result.marksScored! / result.totalQuestions!,
                indicatorColor: AppColors.white,
                progressColor: (controller.examHistory.indexOf(result) + 1) % 2 == 0
                    ? AppColors.blueGrade2
                    : AppColors.pinkGrade2,
                trailingText: "${result.marksScored}/${result.totalQuestions}",
                trailingFontWeight: fontWeight700,
                trailingFontSize: font_16,
                trailingTextColor: AppColors.white,
                onTap: controller.handleCardNavigation,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
