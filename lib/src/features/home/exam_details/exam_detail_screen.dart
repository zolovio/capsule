import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_text.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'exam_detail_controller.dart';



class ExamDetailScreen extends GetView<ExamDetailController> {
  const ExamDetailScreen({Key? key}) : super(key: key);








  @override
  Widget build(BuildContext context) {
    print("building context");
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
        children: [
          //for (var i = 0; i <= controller.mcqHistory.length; i++)

          for (final questionData in controller.mcqHistory)
            Card(
              elevation: 0,
              color: AppColors.pinkFillColor,
              margin: EdgeInsets.all(margin_5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius_15),
                side: const BorderSide(color: AppColors.pinkGrade2),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "${controller.mcqHistory.indexOf(questionData)+1 }.",
                      fontWeight: fontWeight600,
                      fontSize: font_16,
                      textColor: AppColors.black,
                    ),
                    CustomDivider(height: height_10, isDivider: false),
                    CustomText(
                      text: questionData.question!,
                      fontWeight: fontWeight600,
                      fontSize: font_15,
                      textColor: AppColors.black,
                    ),
                    CustomDivider(height: height_15, isDivider: false),
                    Column(
                      children: controller.options
                          .map<Widget>(
                            (e) => Card(
                          elevation: 0,
                          color: controller.currentIndex == controller.options.indexOf(e)
                              ? AppColors.pinkGrade2
                              : AppColors.pinkFillColor,
                          margin: EdgeInsets.symmetric(vertical: margin_10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radius_7),
                            side: const BorderSide(color: AppColors.pinkGrade2),
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(margin_10),
                            child: CustomText(
                              text: e,
                              fontWeight: fontWeight600,
                              fontSize: font_14,
                              textColor:
                              controller.currentIndex == controller.options.indexOf(e)
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

