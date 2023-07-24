import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_list_tile.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'mcq_topics_controller.dart';

class McqTopicsScreen extends GetView<McqTopicController> {
  const McqTopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        appBar: AppBar(),
        text: strSetOfMcq,
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
            : controller.chaptersList.isEmpty
                ? const Center(
                    child: Text('No data found'),
                  )
                : ListView(
                    padding: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_10),
                    children: controller.chaptersList.map<Widget>(
                      (topic) {
                        Color color = controller.chaptersList.indexOf(topic) % 2 == 1
                            ? AppColors.blueGrade2
                            : AppColors.pinkGrade2;

                        return CustomListTile(
                          margin: margin_5,
                          tileColor: color,
                          radius: radius_15,
                          avatarColor: AppColors.white,
                          leadingText: (controller.chaptersList.indexOf(topic) + 1).toString(),
                          leadingFontWeight: fontWeight700,
                          leadingFontSize: font_16,
                          leadingTextColor: AppColors.black,
                          titleText: topic.name!,
                          titleFontWeight: fontWeight700,
                          titleFontSize: font_18,
                          titleTextColor: AppColors.white,
                          subtitleText: '',
                          subtitleFontWeight: fontWeight500,
                          subtitleFontSize: font_14,
                          subtitleTextColor: AppColors.white,
                          isIndicator: false,
                          isSubtitleList: false,
                          onTap: () => controller.handleForwardNavigation(chaptersModel: topic),
                        );
                      },
                    ).toList(),
                  ),
      ),
    );
  }
}
