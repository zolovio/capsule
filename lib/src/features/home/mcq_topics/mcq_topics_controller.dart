import 'package:get/get.dart';

import '../../../core/models/chapters_model.dart';
import '../../../core/models/subjects_model.dart';
import '../../../core/repository/repository.dart';
import '../subject/subjects_controller.dart';
import '../subject_modes/subject_mode_controller.dart';
import '../test_sets/test_set_binding.dart';
import '../test_sets/test_set_screen.dart';

class McqTopicController extends GetxController {
  RepositoryController repository = RepositoryController();
  SubjectsController subjectsController = Get.find<SubjectsController>();
  SubjectModeController subjectModeController = Get.find<SubjectModeController>();

  RxList<ChaptersModel> chaptersList = <ChaptersModel>[].obs;
  Rx<ChaptersModel> selectedChapter = ChaptersModel().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchAllChapters(
        subject: subjectModeController.subjectsModel.value, mode: subjectModeController.mode.value);

    super.onInit();
  }

  Future<void> fetchAllChapters({required SubjectsModel subject, required String mode}) async {
    isLoading.toggle();

    List<ChaptersModel>? chapters = await repository.fetchSubjectChapters(
      className: subjectsController.classes[subjectsController.selectedIndex.value].id!,
      subject: subject.subjectName!,
    );

    chaptersList.value = chapters!;

    isLoading.toggle();
  }

  handleBackNavigation() => Get.back();

  handleForwardNavigation({required ChaptersModel chaptersModel}) {
    selectedChapter.value = chaptersModel;

    Get.to(
      () => TestSetScreen(title: chaptersModel.name!),
      binding: TestSetBinding(),
    );
  }
}
