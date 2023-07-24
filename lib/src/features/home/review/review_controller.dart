import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/palette.dart';
import '../quiz/quiz_controller.dart';
import '../score_board/score_board_controller.dart';

class ReviewController extends GetxController {
  QuizController quizController = Get.find<QuizController>();
  ScoreBoardController scoreBoardController = Get.find<ScoreBoardController>();

  RxDouble skippedRate = 0.0.obs;
  RxDouble correctRate = 0.0.obs;
  RxDouble wrongRate = 0.0.obs;

  RxInt selectedIndex = (-1).obs;
  RxInt currentIndex = 0.obs;

  RxList optionColors = [].obs;
  RxList borderColor = [].obs;

  List<Map<String, dynamic>> chartData = [
    {"title": "Skipped", "value": 0, "color": AppColors.blueGrade2},
    {"title": "Correct", "value": 0, "color": AppColors.pinkGrade2},
    {"title": "Incorrect", "value": 0, "color": AppColors.deepPink},
  ];

  @override
  void onInit() {
    skippedRate.value = scoreBoardController.testScore!.skippedPercentage!;
    correctRate.value = scoreBoardController.testScore!.correctPercentage!;
    wrongRate.value = scoreBoardController.testScore!.incorrectPercentage!;

    chartData[0]["value"] = skippedRate.value;
    chartData[1]["value"] = correctRate.value;
    chartData[2]["value"] = wrongRate.value;

    optionColors.value = List.filled(
      quizController.questionsDetails.length,
      <Color>[],
    );

    borderColor.value = List.filled(
      quizController.questionsDetails.length,
      <Color>[],
    );

    getOptionColors();
    super.onInit();
  }

  void getOptionColors() {
    for (int i = 0; i < quizController.questionsDetails.length; i++) {
      List<Color> filledColor = List.filled(
        quizController.questionsDetails[i].option!.length,
        AppColors.pinkFillColor,
      );

      List<Color> borderColors = List.filled(
        quizController.questionsDetails[i].option!.length,
        AppColors.pinkGrade2,
      );

      for (int j = 0; j < quizController.questionsDetails[i].option!.length; j++) {
        if (quizController.selectedOption[i] == "Not Selected") {
          filledColor[scoreBoardController.testScore!.correctOptions![i] - 1] =
              AppColors.blueGrade2;

          borderColors[scoreBoardController.testScore!.correctOptions![i] - 1] =
              AppColors.blueGrade2;

          optionColors[i] = filledColor;
          borderColor[i] = borderColors;

          break;
        } else if (scoreBoardController.testScore!.correctOptions![i] ==
            double.parse(quizController.selectedOption[i])) {
          filledColor[int.parse(quizController.selectedOption[i]) - 1] = AppColors.pinkGrade3;
          borderColors[int.parse(quizController.selectedOption[i]) - 1] = AppColors.pinkGrade3;

          optionColors[i] = filledColor;
          borderColor[i] = borderColors;
          break;
        } else if (scoreBoardController.testScore!.correctOptions![i] !=
                double.parse(quizController.selectedOption[i]) &&
            quizController.selectedOption[i] != "Not Selected") {
          filledColor[int.parse(quizController.selectedOption[i]) - 1] = AppColors.deepPink;
          borderColors[int.parse(quizController.selectedOption[i]) - 1] = AppColors.deepPink;

          optionColors[i] = filledColor;
          borderColor[i] = borderColors;
          break;
        }
      }
    }
  }
}
