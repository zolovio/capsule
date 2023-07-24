import 'package:get/get.dart';

import '../../../core/models/library_model.dart';
import '../../../core/repository/repository.dart';

class LibraryController extends GetxController {
  RepositoryController repository = RepositoryController();

  RxList<LibraryModel> libraryList = <LibraryModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchLibraryData();

    super.onInit();
  }

  Future<void> fetchLibraryData() async {
    isLoading.toggle();

    List<LibraryModel>? libraries = await repository.fetchLibraryData(userId: 16);

    if (libraries != null && libraries.isNotEmpty) {
      libraryList.value = libraries;
    }

    isLoading.toggle();
  }
}
