// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../core/constants/palette.dart';
import 'controllers/pdf_controller.dart';
import 'components/pdf_thumbnail.dart';
import 'components/search_toolbar.dart';

class CustomSPDFViewer extends StatelessWidget {
  CustomSPDFViewer({Key? key, required this.title, required this.pdfNetworkLink}) : super(key: key);

  final String title;
  final String pdfNetworkLink;

  PdfController controller = Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: controller.showToolbar
            ? AppBar(
                flexibleSpace: SafeArea(
                  child: SearchToolbar(
                    key: controller.textSearchKey,
                    showTooltip: true,
                    controller: controller.pdfViewerController,
                    onTap: (Object toolbarItem) async {
                      if (toolbarItem.toString() == 'Cancel Search') {
                        controller.showToolbar = false;
                        controller.showScrollHead = true;
                        if (Navigator.canPop(context)) {
                          Navigator.maybePop(context);
                        }
                      }
                      if (toolbarItem.toString() == 'noResultFound') {
                        controller.textSearchKey.currentState?.showToast = true;
                        await Future.delayed(const Duration(seconds: 1));

                        controller.textSearchKey.currentState?.showToast = false;
                      }
                    },
                  ),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: const Color(0xFFFAFAFA),
              )
            : AppBar(
                leadingWidth: 0,
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                centerTitle: false,
                title: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.pinkGrade2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      controller.savedBookmarks.contains(controller.currentPage.value)
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: AppColors.pinkGrade2,
                    ),
                    onPressed: () => controller.toggleBookmark(controller.currentPage.value),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.pinkGrade2,
                    ),
                    onPressed: () => controller.onSearchPressed(context),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.text_snippet_outlined,
                      color: AppColors.pinkGrade2,
                    ),
                    onPressed: () => controller.openAddEntryDialog(context),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.showGrid!.toggle();
                    },
                    icon: Icon(
                      controller.showGrid!.isTrue ? Icons.grid_view_sharp : Icons.grid_view,
                      color: AppColors.pinkGrade2,
                    ),
                  ),
                ],
              ),
        body: controller.showGrid!.isTrue
            ? PdfThumbnail.fromFile(
                controller.filePath!.value,
                currentPage: controller.currentPage.value,
                count: 3,
                filters: const {},
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                height: MediaQuery.of(context).size.height / 1.13,
                currentPageWidget: (page, isCurrentPage) {
                  return Container(
                    height: 25,
                    width: 25,
                    color: isCurrentPage ? Colors.purple : Colors.grey,
                    alignment: Alignment.center,
                    child: Text(
                      '$page',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                currentPageDecoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.purple,
                      width: 3,
                    ),
                  ),
                ),
                onPageClicked: (page) {
                  controller.currentPage.value = page + 1;

                  controller.showGrid!.toggle();

                  controller.pdfViewerController.jumpToPage(page + 1);
                },
              )
            : controller.isLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SfPdfViewer.memory(
                    controller.documentBytes!.value,
                    controller: controller.pdfViewerController,
                    key: controller.pdfViewerKey,
                    pageSpacing: 0,
                    scrollDirection: PdfScrollDirection.horizontal,
                    pageLayoutMode: PdfPageLayoutMode.single,
                    interactionMode: PdfInteractionMode.selection,
                    initialZoomLevel: 1,
                    maxZoomLevel: 5,
                    canShowScrollHead: controller.showScrollHead,
                    onDocumentLoaded: (PdfDocumentLoadedDetails details) async {},
                    onTextSelectionChanged: (PdfTextSelectionChangedDetails details) async {
                      if (details.selectedText == null && controller.overlayEntry != null) {
                        controller.checkAndCloseContextMenu();
                      } else if (details.selectedText != null && controller.overlayEntry == null) {
                        controller.showContextMenu(details.globalSelectedRegion!, context, details);
                      }
                    },
                    onPageChanged: (PdfPageChangedDetails details) {
                      controller.currentPage.value = details.newPageNumber;
                    },
                    onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {},
                    onHyperlinkClicked: (PdfHyperlinkClickedDetails details) {},
                    onZoomLevelChanged: (PdfZoomDetails details) {},
                  ),
      ),
    );
  }
}
