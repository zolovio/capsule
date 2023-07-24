import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_text.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'review_controller.dart';

class ReviewScreen extends GetView<ReviewController> {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        appBar: AppBar(),
        text: strReviewAnswer,
        fontWeight: fontWeight600,
        fontSize: font_20,
        textColor: AppColors.pinkGrade2,
        isEmptyTitle: false,
      ),
      body: ListView(
        children: [
          SfCircularChart(
            series: [
              DoughnutSeries<ChartData, String>(
                xValueMapper: (ChartData data, _) => data.category,
                yValueMapper: (ChartData data, _) => data.value,
                pointColorMapper: (ChartData data, _) => data.color,
                dataLabelMapper: (ChartData data, _) => data.percent,
                startAngle: 190,
                endAngle: 190,
                radius: "90%",
                innerRadius: "75%",
                dataLabelSettings: DataLabelSettings(
                  angle: 0,
                  isVisible: true,
                  showZeroValue: false,
                  alignment: ChartAlignment.center,
                  labelPosition: ChartDataLabelPosition.inside,
                  labelAlignment: ChartDataLabelAlignment.auto,
                  labelIntersectAction: LabelIntersectAction.shift,
                  textStyle: TextStyle(
                    fontWeight: fontWeight600,
                    fontSize: font_10,
                    color: AppColors.black,
                  ),
                ),
                dataSource: controller.chartData
                    .map(
                      (chart) => ChartData(
                        chart["title"],
                        chart["value"].toDouble(),
                        "${chart["value"] % 1 == 0 ? chart["value"].toInt() : chart["value"]}%",
                        chart["color"],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.chartData
                .map<Widget>(
                  (chart) => CustomContainer(
                    radius: radius_6,
                    containerColor: chart["color"],
                    text: chart["title"],
                    fontWeight: fontWeight600,
                    fontSize: font_13,
                    textColor: AppColors.black,
                    paddingHorizontal: margin_8,
                    paddingVertical: margin_15,
                    width: width_5,
                    height: height_5,
                    isResult: true,
                  ),
                )
                .toList(),
          ),
          Column(
            children: controller.quizController.questionsDetails.map((ques) {
              controller.currentIndex.value++;
              ++controller.selectedIndex.value;

              return Card(
                elevation: 0,
                color: AppColors.pinkFillColor,
                margin: EdgeInsets.all(margin_25),
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
                        text: "${controller.currentIndex.value}.",
                        fontWeight: fontWeight600,
                        fontSize: font_16,
                        textColor: AppColors.black,
                      ),
                      CustomDivider(height: height_10, isDivider: false),
                      CustomText(
                        text: ques.question!,
                        fontWeight: fontWeight600,
                        fontSize: font_15,
                        textColor: AppColors.black,
                      ),
                      CustomDivider(height: height_15, isDivider: false),
                      Column(
                        children: ques.option!.map<Widget>(
                          (option) {
                            return Card(
                              elevation: 0,
                              color: controller.optionColors[controller.selectedIndex.value]
                                  [ques.option!.indexOf(option)],
                              margin: EdgeInsets.symmetric(vertical: margin_10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(radius_7),
                                side: BorderSide(
                                    color: controller.borderColor[controller.selectedIndex.value]
                                        [ques.option!.indexOf(option)]),
                              ),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(margin_10),
                                child: CustomText(
                                  text: option,
                                  fontWeight: fontWeight600,
                                  fontSize: font_14,
                                  textColor:
                                      // controller.currentIndex ==
                                      //         controller.quizController.questionsDetails.indexOf(ques)
                                      //     ? AppColors.white
                                      //     :
                                      AppColors.black,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String category;
  final double value;
  final String percent;
  final Color color;

  ChartData(
    this.category,
    this.value,
    this.percent,
    this.color,
  );
}
