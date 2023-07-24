import 'package:get/get.dart';

import 'score_board_controller.dart';

class ScoreBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ScoreBoardController>(ScoreBoardController());
  }
}
