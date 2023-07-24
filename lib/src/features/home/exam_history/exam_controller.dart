import 'package:get/get.dart';

import '../../../core/configs/routes.dart';
import '../../../core/models/exam_history_model.dart';
import '../../../core/repository/repository.dart';

class ExamsController extends GetxController {
  RepositoryController repository = RepositoryController();

  RxList<ExamHistoryModel> examHistory = <ExamHistoryModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchExamHistory();
    super.onInit();
  }

  Future<void> fetchExamHistory() async {
    isLoading.toggle();

    List<ExamHistoryModel>? examResults = await repository.fetchExamHistory(userId: 16);

    if (examResults != null) {
      examHistory.value = examResults;

      examHistory.sort((a, b) => a.historyId!.compareTo(b.historyId!));
    }

    isLoading.toggle();
  }

  handleCardNavigation() => Get.toNamed(AppRoutes.getExamDetailRoute());
}
