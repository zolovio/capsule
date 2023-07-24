import 'dart:async';

import 'package:get/get.dart';

import '../../../core/configs/routes.dart';
import '../../../core/models/questions_model.dart';
import '../../../core/repository/repository.dart';
import '../subject/subjects_controller.dart';
import '../subject_modes/subject_mode_controller.dart';
import '../test_sets/test_set_controller.dart';

class QuizController extends GetxController {
  RepositoryController repository = RepositoryController();
  SubjectsController subjectsController = Get.find<SubjectsController>();
  SubjectModeController subjectModeController = Get.find<SubjectModeController>();
  TestSetController testSetController = Get.find<TestSetController>();

  Timer? countdownTimer;
  Rx<Duration> duration = const Duration(minutes: 10).obs;
  RxList<QuestionsModel> questionsDetails = <QuestionsModel>[].obs;
  List<String> selectedOption = <String>[];
  RxString minutes = "10".obs;
  RxString seconds = "00".obs;

  RxInt currentStep = 0.obs;
  RxInt currentIndex = (-1).obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    startTimer();
    fetchQuestions();

    super.onInit();
  }

  Future<void> fetchQuestions() async {
    isLoading.toggle();

    List<QuestionsModel>? testList = await repository.fetchQuestionsDetails(
        testId: testSetController.selectedTestData.value.testID!,
        subject: subjectModeController.subjectsModel.value.subjectName!,
        className: subjectsController.classId.value,
        mode: subjectModeController.mode.value.split(" ")[0]);

    if (testList != null && testList.isNotEmpty) {
      questionsDetails.value = testList;
      selectedOption = List<String>.filled(questionsDetails.length, "");
    }
    isLoading.toggle();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;

    final second = duration.value.inSeconds - reduceSecondsBy;

    if (second < 0) {
      countdownTimer!.cancel();
    } else {
      duration.value = Duration(seconds: second);

      minutes.value = strDigits(duration.value.inMinutes.remainder(10));
      seconds.value = strDigits(duration.value.inSeconds.remainder(60));
    }
  }

  String strDigits(int n) => n.toString().padLeft(2, '0');

  handleOptionTap(int index) {
    currentIndex.value = index;
    selectedOption[currentStep.value] = (index + 1).toString();
  }

  onStepContinue() {
    if (selectedOption[currentStep.value].trim() == "") {
      selectedOption[currentStep.value] = "Not Selected";
    }

    ++currentStep;
    currentIndex.value = -1;
  }

  onStepCancel() {
    if (selectedOption.last.trim() == "") selectedOption.last = "Not Selected";

    Get.offAndToNamed(AppRoutes.getScoreBoardRoute());
  }
}
