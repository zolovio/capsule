// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_list_tile.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import 'test_set_controller.dart';

class TestSetScreen extends GetView<TestSetController> {
  const TestSetScreen({Key? key, required this.title}) : super(key: key);

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
          isEmptyTitle: false,
        ),
        body: Obx(
          () => controller.isLoading.isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.testDetails.isEmpty
                  ? const Center(
                      child: Text('No data found'),
                    )
                  : ListView(
                      padding: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_10),
                      children: controller.testDetails.map<Widget>(
                        (test) {
                          Color color = controller.testDetails.indexOf(test) % 2 == 1
                              ? AppColors.blueGrade2
                              : AppColors.pinkGrade2;

                          return CustomListTile(
                            margin: margin_5,
                            tileColor: color,
                            radius: radius_15,
                            avatarColor: AppColors.white,
                            leadingText: (controller.testDetails.indexOf(test) + 1).toString(),
                            leadingFontWeight: fontWeight700,
                            leadingFontSize: font_16,
                            leadingTextColor: AppColors.black,
                            titleText: test.name!,
                            titleFontWeight: fontWeight700,
                            titleFontSize: font_18,
                            titleTextColor: AppColors.white,
                            subtitleList: {
                              "questionsCount": test.questionsCount,
                              "hours": test.hours,
                              "minutes": test.minutes,
                              "seconds": test.seconds,
                            },
                            subtitleFontWeight: fontWeight400,
                            subtitleFontSize: font_11,
                            subtitleTextColor: AppColors.white,
                            isIndicator: false,
                            isSubtitleList: true,
                            onTap: () => controller.handleForwardNavigation(testDetailsModel: test),
                          );
                        },
                      ).toList(),
                    ),
        ));
  }
}
