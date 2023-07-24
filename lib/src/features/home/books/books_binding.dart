import 'package:get/get.dart';

import 'books_controller.dart';

class BooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BooksController>(BooksController(), permanent: true);
  }
}
