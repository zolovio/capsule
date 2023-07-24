import 'package:get/get.dart';

import '../../../core/configs/routes.dart';
import '../../../core/models/classes_model.dart';
import '../books/books_controller.dart';
import '../exam_history/exam_controller.dart';
import '../exam_history/exam_screen.dart';
import '../library/library_controller.dart';
import '../subject/subjects_controller.dart';

class DashboardController extends GetxController {
  late SubjectsController subjectsController = Get.put(SubjectsController());
  late BooksController booksController = Get.put(BooksController());
  late ExamsController examHistoryController = Get.put(ExamsController());
  late LibraryController libraryController = Get.put(LibraryController());

  RxList<ClassesModel> classes = <ClassesModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void onToggleSelected(int index, int classId) {
    subjectsController.selectedIndex.value = index;
    subjectsController.classId.value = classId;

    subjectsController.fetchClassSubjects(classId: classId);
  }

  handleSubjectNavigation() => Get.toNamed(AppRoutes.getSubjectsRoute());

  handleBookNavigation() => Get.toNamed(AppRoutes.getBooksRoute());

  handleSeeAllHistoryNavigation() => Get.to(() => ExamsScreen());

  handleHistoryNavigation() => Get.toNamed(AppRoutes.getExamDetailRoute());
}
