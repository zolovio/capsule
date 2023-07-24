// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_stepper.dart';
import '../../../components/custom_text.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/models/questions_model.dart';
import 'quiz_controller.dart';

class QuizScreen extends GetView<QuizController> {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: controller.questionsDetails.isNotEmpty
            ? CustomAppbar(
                appBar: AppBar(),
                text: "${controller.minutes.value} : ${controller.seconds.value}",
                fontWeight: fontWeight600,
                fontSize: font_20,
                textColor: AppColors.pinkGrade2,
                isEmptyTitle: false,
                isTimer: true,
                isCenter: true,
              )
            : AppBar(),
        body: Obx(
          () => controller.isLoading.isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.questionsDetails.isNotEmpty
                  ? ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: margin_5, vertical: margin_10),
                      children: [
                        Center(child: _buildStepper()),
                      ],
                    )
                  : const Center(
                      child: Text('No data found'),
                    ),
        ),
      ),
    );
  }

  CupertinoStepper _buildStepper() {
    final canCancel = controller.currentStep > 0;
    final canContinue = controller.currentStep < controller.questionsDetails.length;

    return CupertinoStepper(
      type: StepperType.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      currentStep: controller.currentStep.value,
      continueButtonColor: AppColors.pinkGrade2,
      continueButtonTextColor: AppColors.white,
      onStepCancel: canCancel ? controller.onStepCancel : null,
      onStepContinue: canContinue ? controller.onStepContinue : null,
      steps: [
        for (var i = 0; i < controller.questionsDetails.length; i++)
          _buildStep(
            title: const Text(''),
            index: i,
            question: controller.questionsDetails[i],
            isActive: i == controller.currentStep.value,
            state: i == controller.currentStep.value
                ? StepState.indexed
                : i < controller.currentStep.value
                    ? StepState.disabled
                    : StepState.indexed,
          ),
      ],
    );
  }

  Step _buildStep({
    required Widget title,
    required int index,
    required QuestionsModel question,
    StepState state = StepState.indexed,
    bool isActive = false,
  }) {
    return Step(
      title: const Text(''),
      state: state,
      isActive: isActive,
      content: Card(
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
                text: "${index + 1}",
                fontWeight: fontWeight600,
                fontSize: font_16,
                textColor: AppColors.black,
              ),
              CustomDivider(height: height_10, isDivider: false),
              CustomText(
                text: question.question!,
                fontWeight: fontWeight600,
                fontSize: font_15,
                textColor: AppColors.black,
              ),
              CustomDivider(height: height_15, isDivider: false),
              Column(
                children: controller.questionsDetails[controller.currentStep.value].option!
                    .map<Widget>(
                      (quest) => InkWell(
                        onTap: () => controller.handleOptionTap(controller
                            .questionsDetails[controller.currentStep.value].option!
                            .indexOf(quest)),
                        child: Obx(
                          () => Card(
                            elevation: 0,
                            margin: EdgeInsets.only(bottom: margin_20),
                            color: controller.currentIndex.value ==
                                    controller
                                        .questionsDetails[controller.currentStep.value].option!
                                        .indexOf(quest)
                                ? AppColors.pinkGrade2
                                : AppColors.pinkFillColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radius_7),
                              side: const BorderSide(color: AppColors.pinkGrade2),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: ListTile(
                                dense: true,
                                minLeadingWidth: width_10,
                                contentPadding: EdgeInsets.symmetric(horizontal: margin_10),
                                leading: CustomText(
                                  text:
                                      "${controller.questionsDetails[controller.currentStep.value].option!.indexOf(quest) + 1}",
                                  fontWeight: fontWeight600,
                                  fontSize: font_14,
                                  textColor: controller.currentIndex.value ==
                                          controller.questionsDetails[controller.currentStep.value]
                                              .option!
                                              .indexOf(quest)
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                                title: CustomText(
                                  text: quest,
                                  fontWeight: fontWeight600,
                                  fontSize: font_14,
                                  textColor: controller.currentIndex.value ==
                                          controller.questionsDetails[controller.currentStep.value]
                                              .option!
                                              .indexOf(quest)
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                              ),
                            ),
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
    );
  }
}
