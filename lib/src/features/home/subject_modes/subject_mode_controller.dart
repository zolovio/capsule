import 'package:get/get.dart';

import '../../../core/configs/routes.dart';
import '../../../core/models/subjects_model.dart';
import '../subject/subjects_controller.dart';

class SubjectModeController extends GetxController {
  SubjectsController subjectsController = Get.find<SubjectsController>();

  Rx<SubjectsModel> subjectsModel = SubjectsModel().obs;
  RxString mode = "".obs;
  RxInt selectedIndex = 0.obs;

  List<String> modes = ["Exam Mode", "Practice Mode"];

  void onSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  onSubjectTapped({required String mode, required SubjectsModel subjectsModel}) {
    this.subjectsModel.value = subjectsModel;
    this.mode.value = mode;

    Get.toNamed(AppRoutes.getMcqTopicsRoute());
  }
}
