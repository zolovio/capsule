import 'package:get/get.dart';

import '../../../core/models/chapters_model.dart';
import '../../../core/models/test_details_model.dart';
import '../../../core/repository/repository.dart';
import '../mcq_topics/mcq_topics_controller.dart';
import '../subject_detail/subject_detail_binding.dart';
import '../subject_detail/subject_detail_screen.dart';

class TestSetController extends GetxController {
  RepositoryController repository = RepositoryController();

  McqTopicController mcqTopicController = Get.find<McqTopicController>();

  RxList<TestDetailsModel> testDetails = <TestDetailsModel>[].obs;
  Rx<TestDetailsModel> selectedTestData = TestDetailsModel().obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchTestDetails(chapter: mcqTopicController.selectedChapter.value);
    super.onInit();
  }

  Future<void> fetchTestDetails({required ChaptersModel chapter}) async {
    isLoading.toggle();

    List<TestDetailsModel>? testList = await repository.fetchTestDetails(
      chapterId: chapter.id!,
      className: mcqTopicController.subjectsController.classId.value,
      subject: mcqTopicController.subjectModeController.subjectsModel.value.subjectName!,
      mode: mcqTopicController.subjectModeController.mode.value.split(" ")[0],
    );

    testDetails.value = testList!;

    isLoading.toggle();
  }

  handleBackNavigation() => Get.back();

  handleForwardNavigation({required TestDetailsModel testDetailsModel}) {
    selectedTestData.value = testDetailsModel;

    Get.to(
      () => SubjectDetailsScreen(
          title: mcqTopicController.subjectModeController.subjectsModel.value.subjectName!),
      binding: SubjectDetailsBinding(),
    );
  }
}
