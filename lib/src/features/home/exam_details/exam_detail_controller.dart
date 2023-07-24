import 'package:capsule_new/src/core/models/history_model.dart';
import 'package:capsule_new/src/core/repository/repository.dart';
import 'package:get/get.dart';

class ExamDetailController extends GetxController {
  // int currentIndex = 0;
  //
  List<String> options = [
    "A. dvdssdjvsdvldsvs",
    "B. dvdssdjvsdvldsvs",
    "C. dvdssdjvsdvldsvs",
    "D. dvdssdjvsdvldsvs"
  ];

  RepositoryController repository = RepositoryController();

  RxList<HistoryModel> mcqHistory = <HistoryModel>[].obs;

  RxBool isLoading = false.obs;

  int currentIndex = 0;

  @override
  void onInit() {
    fetchMcqHistory();
    super.onInit();
  }

  Future<void> fetchMcqHistory() async {
    isLoading.toggle();

    // int historyId = Get.arguments; // Assuming you are passing the historyId as an argument when navigating to the ExamDetailController.

    List<HistoryModel>? mcqHist = await repository.fetchHistoryModel(historyId:110);

    if (mcqHist != null) {
      //    print(mcqHist);
      mcqHistory.value = mcqHist;

    }

    isLoading.toggle();
  }


  handleOptionTap(int index) => currentIndex = index;
}
