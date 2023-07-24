import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart' as pdf;

import 'pdf_controller.dart';
import '../components/pdf_thumbnail.dart';

class AnnotationController extends GetxController {
  static AnnotationController get instance => Get.find();

  PdfController pdfController = Get.find<PdfController>();

  RxInt currentIndex = 0.obs;
  RxList highlights = [].obs;
  RxList bookmarks = [].obs;
  String dropdownValue = "";

  late ImageThumbnailCacher? cacher;
  Map<int, Uint8List> images = <int, Uint8List>{};
  RxMap<int?, Uint8List?> filters = <int?, Uint8List?>{}.obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getIndexedHighlights();
    getIndexedBookmarks();

    super.onInit();
  }

  void updateIndex(index) {
    currentIndex.value = index;
  }

  void getIndexedHighlights() {
    isLoading.toggle();

    List<Map<String, dynamic>> highlightText = [];

    if (pdfController.savedHighlights.isNotEmpty) {
      for (int i = 1; i <= pdfController.savedHighlights.last["index"]; i++) {
        String text = "";
        String pageNo = "";
        String color = "";

        for (int j = 0; j < pdfController.savedHighlights.length; j++) {
          if (pdfController.savedHighlights[j]["index"] == i) {
            text += " ${pdfController.savedHighlights[j]["text"]}";
            pageNo = "${pdfController.savedHighlights[j]["page"] + 1}";
            color = "${pdfController.savedHighlights[j]["colour"]}";
          }
        }

        highlightText.add({
          "page": pageNo,
          "text": text,
          "color": color,
        });
      }
    }

    highlights.value = highlightText;

    isLoading.toggle();
  }

  Future<void> getIndexedBookmarks() async {
    isLoading.toggle();

    if (pdfController.savedBookmarks.isNotEmpty) {
      bookmarks.addAll(pdfController.savedBookmarks);
    }

    final pdf.PdfDocument pdfDocument =
        await pdf.PdfDocument.openFile(pdfController.filePath!.value);

    try {
      for (var pageNumber = 1; pageNumber <= pdfDocument.pagesCount; pageNumber++) {
        final pdf.PdfPage page = await pdfDocument.getPage(pageNumber);

        final pageImage = await page.render(
          width: page.width,
          height: page.height,
        );
        images[pageNumber] = pageImage!.bytes;
        await page.close();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    for (int element in bookmarks) {
      filters.addAll(filter(element, SplayTreeMap.of(images)));
    }

    isLoading.toggle();
  }
}
