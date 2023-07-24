import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;

import '../components/annotation_dialog.dart';
import '../components/search_toolbar.dart';

enum ContainerType { text, color }

class PdfController extends GetxController {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  late PdfViewerController pdfViewerController;
  late PdfBookmark pdfBookmark;

  final GlobalKey<SearchToolbarState> textSearchKey = GlobalKey();
  late bool showToolbar;
  late bool showScrollHead;
  LocalHistoryEntry? historyEntry;

  var arguments = Get.arguments;
  Rx<Uint8List>? documentBytes = Uint8List(0).obs;
  OverlayEntry? overlayEntry;
  double xOffset = 0.0;
  double yOffset = 0.0;

  RxInt currentPage = 1.obs;
  List savedHighlights = [];
  List savedUnderlines = [];
  RxList<int> savedBookmarks = <int>[].obs;

  RxBool isLoading = false.obs;

  RxString? filePath = "".obs;
  RxDouble? zoomLevel = 1.0.obs;
  RxBool? showGrid = false.obs;
  RxInt? pagesLength = 0.obs;

  @override
  void onInit() {
    pdfViewerController = PdfViewerController();
    showToolbar = false;
    showScrollHead = true;

    loadSavedHighlights();
    loadSavedUnderlines();
    loadSavedBookmarks();

    getPdfBytes();

    super.onInit();
  }

  void getPdfBytes() async {
    isLoading.toggle();

    http.Response response =
        await http.get(Uri.parse(arguments[0]), headers: {"user_id": 16.toString()});

    documentBytes!.value = response.bodyBytes;

    final file = File('${(await getTemporaryDirectory()).path}/${arguments[1]}.pdf');

    filePath!.value = file.path;

    await file.create(recursive: true);
    File newFile = await file.writeAsBytes(documentBytes!.value.buffer
        .asUint8List(documentBytes!.value.offsetInBytes, documentBytes!.value.lengthInBytes));

    final PdfDocument document = PdfDocument(inputBytes: newFile.readAsBytesSync());

    pagesLength!.value = document.pages.count;

    for (var highlight in savedHighlights) {
      final PdfPage page = document.pages[highlight["page"]];

      final PdfRectangleAnnotation rectangleAnnotation = PdfRectangleAnnotation(
        Rect.fromLTRB(
          highlight["bounds"]["left"],
          highlight["bounds"]["top"],
          highlight["bounds"]["right"],
          highlight["bounds"]["bottom"],
        ),
        'Highlight Annotation',
        author: 'Syncfusion',
        color: PdfColor(
          highlight["color"][0],
          highlight["color"][1],
          highlight["color"][2],
        ),
        innerColor: PdfColor(
          highlight["color"][0],
          highlight["color"][1],
          highlight["color"][2],
        ),
        opacity: 0.5,
      );

      page.annotations.add(rectangleAnnotation);
      page.annotations.flattenAllAnnotations();
    }

    for (var underline in savedUnderlines) {
      final PdfPage page = document.pages[underline["page"]];

      final PdfLineAnnotation lineAnnotation = PdfLineAnnotation(
        [
          underline["line_points"][0],
          underline["line_points"][1],
          underline["line_points"][2],
          underline["line_points"][3],
        ],
        'Underline Annotation',
        author: 'Syncfusion',
        innerColor: PdfColor(255, 0, 0),
        color: PdfColor(255, 0, 0),
      );

      page.annotations.add(lineAnnotation);
      page.annotations.flattenAllAnnotations();
    }

    final List<int> bytes = document.saveSync();

    documentBytes!.value = Uint8List.fromList(bytes);
    pdfViewerController.jumpToPage(currentPage.value);

    // documentBytes!.value = newFile.readAsBytesSync();
    // documentBytes!.value = await http.readBytes(
    //     Uri.parse('https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'));

    isLoading.toggle();
  }

  Future<void> showContextMenu(
    Rect rect,
    BuildContext context,
    PdfTextSelectionChangedDetails? details,
  ) async {
    final RenderBox renderBoxContainer = context.findRenderObject()! as RenderBox;

    const double kContextMenuHeight = 50;
    const double kContextMenuWidth = 310;

    const double kHeight = 18;

    final Offset containerOffset = renderBoxContainer.localToGlobal(
      renderBoxContainer.paintBounds.topLeft,
    );

    if (details != null && containerOffset.dy < details.globalSelectedRegion!.topLeft.dy ||
        (containerOffset.dy <
                (details!.globalSelectedRegion!.center.dy - (kContextMenuHeight / 2)) &&
            details.globalSelectedRegion!.height > kContextMenuWidth)) {
      double top = 0.0;
      double left = 0.0;

      final Rect globalSelectedRect = details.globalSelectedRegion!;

      if ((globalSelectedRect.top) > MediaQuery.of(context).size.height / 2) {
        top = globalSelectedRect.topLeft.dy + details.globalSelectedRegion!.height + kHeight;
        left = globalSelectedRect.bottomLeft.dx;
      } else {
        top = globalSelectedRect.height > kContextMenuWidth
            ? globalSelectedRect.center.dy - (kContextMenuHeight / 2)
            : globalSelectedRect.topLeft.dy + details.globalSelectedRegion!.height + kHeight;
        left = globalSelectedRect.height > kContextMenuWidth
            ? globalSelectedRect.center.dx - (kContextMenuWidth / 2)
            : globalSelectedRect.bottomLeft.dx;
      }

      if (globalSelectedRect.left > MediaQuery.of(context).size.width / 2) {
        left = globalSelectedRect.centerLeft.dx / 2 - 80;
      }

      final OverlayState overlayState = Overlay.of(context, rootOverlay: true);
      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: top,
          left: left,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.14),
                  blurRadius: 2,
                  offset: Offset(0, 0),
                ),
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.12),
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            constraints:
                const BoxConstraints.tightFor(width: kContextMenuWidth, height: kContextMenuHeight),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 3.0),
                      child: Icon(Icons.cancel_outlined),
                    ),
                  ),
                  const VerticalDivider(color: Colors.white),
                  _addAnnotation(
                    'Highlight',
                    details.selectedText,
                    ContainerType.color,
                    Colors.yellow.shade300,
                    PdfColor(255, 255, 51),
                    [255, 255, 51],
                    "yellow",
                  ),
                  const VerticalDivider(color: Colors.white),
                  _addAnnotation(
                    'Highlight',
                    details.selectedText,
                    ContainerType.color,
                    Colors.green.shade300,
                    PdfColor(153, 255, 153),
                    [153, 255, 153],
                    "green",
                  ),
                  const VerticalDivider(color: Colors.white),
                  _addAnnotation(
                    'Highlight',
                    details.selectedText,
                    ContainerType.color,
                    Colors.blueAccent.shade100,
                    PdfColor(102, 178, 255),
                    [102, 178, 255],
                    "blue",
                  ),
                  const VerticalDivider(color: Colors.white),
                  _addAnnotation(
                    'Highlight',
                    details.selectedText,
                    ContainerType.color,
                    Colors.pinkAccent.shade100,
                    PdfColor(255, 102, 178),
                    [255, 102, 178],
                    "pink",
                  ),
                  const VerticalDivider(color: Colors.white),
                  GestureDetector(
                      onTap: () {
                        checkAndCloseContextMenu();
                        // await Clipboard.setData(ClipboardData(text: selectedText));
                        _drawAnnotation(
                          "Underline",
                          PdfColor.fromCMYK(0, 100, 100, 0),
                          [0, 100, 100, 0],
                          "red",
                        );
                      },
                      child: const Icon(Icons.format_underline)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    child: VerticalDivider(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: details.selectedText!));
                      pdfViewerController.clearSelection();
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0, bottom: 4.0, left: 5.0),
                      child: DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        child: Text(
                          "Copy",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      overlayState.insert(overlayEntry!);
    }
  }

  Widget _addAnnotation(
    String? annotationType,
    String? selectedText,
    ContainerType type,
    Color color,
    PdfColor pdfColor,
    List<int> cmyk,
    String colour,
  ) {
    return GestureDetector(
      onTap: () async {
        checkAndCloseContextMenu();
        // await Clipboard.setData(ClipboardData(text: selectedText));
        _drawAnnotation(annotationType, pdfColor, cmyk, colour);
      },
      child: Container(
        width: 25,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Future<void> _drawAnnotation(
      String? annotationType, PdfColor color, List<int> cmyk, String colour) async {
    final PdfDocument document = PdfDocument(inputBytes: documentBytes!.value);

    switch (annotationType) {
      case 'Highlight':
        {
          List<Map<String, dynamic>> highlight = [];

          highlight.addAll(savedHighlights.map((e) => e));

          int index = savedHighlights.isEmpty ? 1 : savedHighlights.last["index"] + 1;

          pdfViewerKey.currentState!.getSelectedTextLines().forEach((pdfTextLine) async {
            final PdfPage page = document.pages[pdfTextLine.pageNumber];

            final PdfRectangleAnnotation rectangleAnnotation = PdfRectangleAnnotation(
              pdfTextLine.bounds,
              'Highlight Annotation',
              author: 'Syncfusion',
              color: color,
              innerColor: color,
              opacity: 0.5,
            );

            addHighlight({
              "index": index,
              "page": pdfTextLine.pageNumber,
              "text": pdfTextLine.text,
              "bounds": {
                "left": pdfTextLine.bounds.left,
                "top": pdfTextLine.bounds.top,
                "right": pdfTextLine.bounds.right,
                "bottom": pdfTextLine.bounds.bottom,
              },
              "color": cmyk,
              "colour": colour,
            });

            page.annotations.add(rectangleAnnotation);
            page.annotations.flattenAllAnnotations();
          });

          final List<int> bytes = document.saveSync();

          documentBytes!.value = Uint8List.fromList(bytes);
        }
        break;
      case 'Underline':
        {
          List<Map<String, dynamic>> underline = [];

          underline.addAll(savedUnderlines.map((e) => e));

          int index = savedUnderlines.isEmpty ? 1 : savedUnderlines.last["index"] + 1;

          pdfViewerKey.currentState!.getSelectedTextLines().forEach((pdfTextLine) {
            final PdfPage page = document.pages[pdfTextLine.pageNumber];
            final PdfLineAnnotation lineAnnotation = PdfLineAnnotation(
              [
                pdfTextLine.bounds.left.toInt(),
                (document.pages[pdfTextLine.pageNumber].size.height - pdfTextLine.bounds.bottom)
                    .toInt(),
                pdfTextLine.bounds.right.toInt(),
                (document.pages[pdfTextLine.pageNumber].size.height - pdfTextLine.bounds.bottom)
                    .toInt()
              ],
              'Underline Annotation',
              author: 'Syncfusion',
              innerColor: PdfColor(255, 0, 0),
              color: PdfColor(255, 0, 0),
            );

            addUnderline({
              "index": index,
              "page": pdfTextLine.pageNumber,
              "text": pdfTextLine.text,
              "line_points": [
                pdfTextLine.bounds.left.toInt(),
                (document.pages[pdfTextLine.pageNumber].size.height - pdfTextLine.bounds.bottom)
                    .toInt(),
                pdfTextLine.bounds.right.toInt(),
                (document.pages[pdfTextLine.pageNumber].size.height - pdfTextLine.bounds.bottom)
                    .toInt()
              ],
              "color": [255, 0, 0],
            });

            page.annotations.add(lineAnnotation);
            page.annotations.flattenAllAnnotations();
          });

          final List<int> bytes = document.saveSync();
          documentBytes!.value = Uint8List.fromList(bytes);
        }
        break;
      case 'Strikethrough':
        {
          pdfViewerKey.currentState!.getSelectedTextLines().forEach((pdfTextLine) {
            final PdfPage page = document.pages[pdfTextLine.pageNumber];
            final PdfLineAnnotation lineAnnotation = PdfLineAnnotation(
              [
                pdfTextLine.bounds.left.toInt(),
                ((document.pages[pdfTextLine.pageNumber].size.height - pdfTextLine.bounds.bottom) +
                        (pdfTextLine.bounds.height / 2))
                    .toInt(),
                pdfTextLine.bounds.right.toInt(),
                ((document.pages[pdfTextLine.pageNumber].size.height - pdfTextLine.bounds.bottom) +
                        (pdfTextLine.bounds.height / 2))
                    .toInt()
              ],
              'Strikethrough Annotation',
              author: 'Syncfusion',
              innerColor: PdfColor(255, 0, 0),
              color: PdfColor(255, 0, 0),
            );

            page.annotations.add(lineAnnotation);
            page.annotations.flattenAllAnnotations();
          });
          final List<int> bytes = document.saveSync();
          documentBytes!.value = Uint8List.fromList(bytes);
        }
        break;
    }
  }

  void checkAndCloseContextMenu() {
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }

  Future<void> loadSavedHighlights() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    savedHighlights =
        prefs.getString("highlights") != null ? json.decode(prefs.getString("highlights")!) : [];
  }

  Future<void> saveHighlights(List highlights) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String encodedMap = json.encode(highlights);
    savedHighlights = highlights;

    await prefs.setString('highlights', encodedMap);
  }

  Future<void> loadSavedUnderlines() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    savedUnderlines =
        prefs.getString("underlines") != null ? json.decode(prefs.getString("underlines")!) : [];
  }

  Future<void> saveUnderlines(List underlines) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    savedUnderlines = underlines;
    String encodedMap = json.encode(underlines);

    await prefs.setString('underlines', encodedMap);
  }

  Future<void> loadSavedBookmarks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    savedBookmarks.value =
        prefs.getStringList('bookmarks')?.map((str) => int.parse(str)).toList() ?? [];
  }

  Future<void> saveBookmarks(List<int> bookmarks) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> intList = bookmarks.map((bookmark) => bookmark.toString()).toList();

    await prefs.setStringList('bookmarks', intList);
  }

  Future<void> addHighlight(Map<String, dynamic> highlight) async {
    List highlights = savedHighlights;

    if (!highlights.contains(highlight)) {
      highlights.add(highlight);

      await saveHighlights(highlights);
    }
  }

  Future<void> removeHighlight(int page) async {
    // List<int> highlights = savedHighlights;
    // if (highlights.contains(page)) {
    //   highlights.remove(page);
    //   await saveHighlights(highlights);
    // }
  }

  Future<void> addUnderline(Map<String, dynamic> underline) async {
    List underlines = savedUnderlines;

    if (!underlines.contains(underline)) {
      underlines.add(underline);

      await saveUnderlines(underlines);
    }
  }

  Future<void> removeUnderline(int page) async {
    // List<int> highlights = savedHighlights;
    // if (highlights.contains(page)) {
    //   highlights.remove(page);
    //   await saveHighlights(highlights);
    // }
  }

  Future<void> toggleBookmark(int page) async {
    List<int> bookmarks = savedBookmarks;

    if (bookmarks.contains(page)) {
      bookmarks.remove(page);
    } else {
      bookmarks.add(page);
    }

    await saveBookmarks(bookmarks);
  }

  bool isPageHighlighted(int page) {
    return savedHighlights.contains(page);
  }

  bool isPageBookmarked(int page) {
    return savedBookmarks.contains(page);
  }

  void ensureHistoryEntry(BuildContext context) {
    if (historyEntry == null) {
      final ModalRoute<dynamic>? route = ModalRoute.of(context);
      if (route != null) {
        historyEntry = LocalHistoryEntry(onRemove: _handleHistoryEntryRemoved);
        route.addLocalHistoryEntry(historyEntry!);
      }
    }
  }

  void _handleHistoryEntryRemoved() {
    textSearchKey.currentState?.clearSearch();
    showToolbar = false;
    historyEntry = null;
  }

  void openAddEntryDialog(BuildContext context) {
    Get.to(() => AnnotationDialog(), fullscreenDialog: true);
  }

  onSearchPressed(BuildContext context) {
    showScrollHead = false;
    showToolbar = true;
    ensureHistoryEntry(context);
  }
}
