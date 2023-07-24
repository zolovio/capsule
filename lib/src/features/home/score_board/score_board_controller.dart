import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/configs/routes.dart';
import '../../../core/models/score_model.dart';
import '../../../core/repository/repository.dart';
import '../mcq_topics/mcq_topics_controller.dart';
import '../quiz/quiz_controller.dart';
import '../subject/subjects_controller.dart';
import '../subject_modes/subject_mode_controller.dart';
import '../test_sets/test_set_controller.dart';

class ScoreBoardController extends GetxController {
  RepositoryController repository = RepositoryController();

  SubjectsController subjectsController = Get.find<SubjectsController>();
  SubjectModeController subjectModeController = Get.find<SubjectModeController>();
  McqTopicController mcqTopicController = Get.find<McqTopicController>();
  TestSetController testSetController = Get.find<TestSetController>();
  QuizController quizController = Get.find();

  ScoreModel? testScore;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchTestScores();

    super.onInit();
  }

  Future<void> fetchTestScores() async {
    isLoading.toggle();

    ScoreModel? scores = await repository.fetchTestScore(
      testId: testSetController.selectedTestData.value.testID!,
      className: mcqTopicController.subjectsController.classId.value,
      subject: mcqTopicController.subjectModeController.subjectsModel.value.subjectName!,
      mode: mcqTopicController.subjectModeController.mode.value.split(" ")[0],
      userId: 16,
      options: quizController.selectedOption,
    );

    if (scores != null) {
      testScore = scores;
    }

    isLoading.toggle();
  }

  handleReviewNavigation() => Get.toNamed(AppRoutes.getReviewScreenRoute());

  handleHomeRoute() =>
      Get.offNamedUntil(AppRoutes.getHomeScreenRoute(), ModalRoute.withName('/home'));
}
