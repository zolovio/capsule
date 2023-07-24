import 'package:get/get.dart';

import '../../../core/models/books_model.dart';
import '../../../core/repository/repository.dart';

class BooksController extends GetxController {
  RepositoryController repository = RepositoryController();

  RxList<BooksModel> booksList = <BooksModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchBooksList();

    super.onInit();
  }

  Future<void> fetchBooksList() async {
    isLoading.toggle();

    List<BooksModel>? booksModel = await repository.fetchBooks();

    if (booksModel != null) booksList.value = booksModel;

    isLoading.toggle();
  }
}
