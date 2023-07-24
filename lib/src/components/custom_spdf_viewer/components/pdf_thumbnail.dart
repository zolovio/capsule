import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pdfx/pdfx.dart';
import '../controllers/annotation_controller.dart';
import '../controllers/pdf_controller.dart' as cont;

/// Callback when the user taps on a thumbnail
typedef ThumbnailPageCallback = void Function(int page);

/// Function that returns page number widget
typedef CurrentPageWidget = Widget Function(int page, bool isCurrentPage);

/// {@template pdf_thumbnail}
/// Thumbnail viewer for pdfs
/// {@endtemplate}
class PdfThumbnail extends StatefulWidget {
  /// Creates a [PdfThumbnail] from a file.
  factory PdfThumbnail.fromFile(
    String path, {
    Key? key,
    Color? backgroundColor,
    BoxDecoration? currentPageDecoration,
    CurrentPageWidget? currentPageWidget,
    double? height,
    ThumbnailPageCallback? onPageClicked,
    required int currentPage,
    Widget? loadingIndicator,
    ImageThumbnailCacher? cacher,
    bool? scrollToCurrentPage,
    Widget? closeButton,
    required int? count,
    required Map<int?, Uint8List?> filters,
  }) {
    return PdfThumbnail._(
      key: key,
      path: path,
      backgroundColor: backgroundColor ?? Colors.black,
      height: height ?? 200,
      onPageClicked: onPageClicked,
      currentPage: currentPage,
      currentPageWidget: currentPageWidget ?? (page, isCurrent) => const SizedBox(),
      currentPageDecoration: currentPageDecoration ??
          BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.blue,
              width: 4,
            ),
          ),
      loadingIndicator: loadingIndicator ??
          const Center(
            child: CircularProgressIndicator(),
          ),
      cacher: cacher,
      scrollToCurrentPage: scrollToCurrentPage ?? false,
      closeButton: closeButton,
      count: count,
      filters: filters,
    );
  }
  const PdfThumbnail._({
    super.key,
    this.path,
    this.backgroundColor,
    required this.height,
    this.onPageClicked,
    required this.currentPage,
    this.currentPageDecoration,
    this.loadingIndicator,
    this.currentPageWidget,
    this.cacher,
    this.scrollToCurrentPage = false,
    this.closeButton,
    required this.count,
    required this.filters,
  });

  /// File path
  final String? path;

  /// Background color
  final Color? backgroundColor;

  /// Decoration for current page
  final BoxDecoration? currentPageDecoration;

  /// Simple function that returns widget that shows the page number.
  /// Widget will be in [Stack] so you can use [Positioned] or [Align]
  final CurrentPageWidget? currentPageWidget;

  /// Height
  final double height;

  /// Callback to run when a page is clicked
  final ThumbnailPageCallback? onPageClicked;

  /// Current page, index + 1
  final int currentPage;

  /// Loading indicator
  final Widget? loadingIndicator;

  /// Close button
  final Widget? closeButton;

  /// Interface to manage caching
  final ImageThumbnailCacher? cacher;

  /// Whether page browser will scroll to the current page or not,
  /// false by default
  final bool scrollToCurrentPage;

  final int? count;

  final Map<int?, Uint8List?> filters;

  @override
  State<PdfThumbnail> createState() => _PdfThumbnailState();
}

class _PdfThumbnailState extends State<PdfThumbnail> {
  late Future<Map<int, Uint8List>> imagesFuture;
  late ScrollController controller;

  cont.PdfController pdfController = Get.find();

  @override
  void initState() {
    controller = ScrollController();
    imagesFuture = _render(widget.path!, widget.cacher)
      ..then((value) async {
        if (widget.scrollToCurrentPage) {
          WidgetsBinding.instance.addPostFrameCallback((timestamp) {
            swipeToPage(widget.currentPage, value.length);
          });
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (widget.closeButton != null) widget.closeButton!,
          Container(
            height: widget.height,
            color: widget.backgroundColor,
            child: widget.count == 1
                ? ListView.builder(
                    itemCount: pdfController.savedBookmarks.length,
                    itemBuilder: (BuildContext context, int index) {
                      AnnotationController annotationController = Get.find();

                      final pageNumber = annotationController.bookmarks[index];
                      final image = widget.filters[pageNumber];

                      if (image == null) {
                        return const SizedBox();
                      }

                      return GestureDetector(
                        onTap: () => widget.onPageClicked?.call(index),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.grey.shade300,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          annotationController.bookmarks[index] < 10
                                              ? "PAGE 0${annotationController.bookmarks[index]}"
                                              : "PAGE ${annotationController.bookmarks[index]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade500,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      icon: const Icon(Icons.more_vert),
                                      onChanged: (String? newValue) {},
                                      items: <String>[
                                        'Filter',
                                        'Starred',
                                        'All Bookmarks',
                                      ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Column(
                                              children: [
                                                if (value == "Filter") ...[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        value,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () => Get.back(),
                                                        icon: const Icon(
                                                          Icons.close,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                                if (value == "Starred") ...[
                                                  const SizedBox(height: 10),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 15.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              MediaQuery.of(context).size.width / 3,
                                                          child: Text(
                                                            value,
                                                            style: const TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ),
                                                        GFToggle(
                                                          onChanged: (val) {},
                                                          value: false,
                                                          disabledThumbColor:
                                                              const Color(0xFFF1F1F1),
                                                          disabledTrackColor:
                                                              const Color(0xFFE0E0E0),
                                                          // enabledThumbColor: ,
                                                          enabledTrackColor: Colors.purple.shade400,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                                if (value != "Filter" && value != "Starred") ...[
                                                  if (value == "All Bookmarks") ...[
                                                    const SizedBox(height: 10),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 15.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            value,
                                                            style: const TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            " (${annotationController.bookmarks.length.toString()})",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.grey.shade400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ],
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 34.0),
                                  child: DecoratedBox(
                                    key: Key('thumbnail_$pageNumber'),
                                    decoration: const BoxDecoration(color: Colors.white),
                                    child: Image.memory(
                                      image,
                                      width: 100,
                                      height: 150,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : FutureBuilder<Map<int, Uint8List>>(
                    future: imagesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final Map<int, Uint8List> images = snapshot.data!;

                        return GridView.builder(
                          controller: controller,
                          itemCount: images.length,
                          padding: EdgeInsets.symmetric(
                              vertical: widget.height * 0.05, horizontal: widget.height * 0.01),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: widget.count!,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            childAspectRatio: 2 / 3,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final pageNumber = index + 1;
                            final isCurrentPage = pageNumber == widget.currentPage;
                            final image = images[pageNumber];
                            if (image == null) {
                              return const SizedBox();
                            }
                            return GestureDetector(
                              onTap: () => widget.onPageClicked?.call(index),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Stack(
                                  children: [
                                    DecoratedBox(
                                      key: Key('thumbnail_$pageNumber'),
                                      decoration: isCurrentPage
                                          ? widget.currentPageDecoration!
                                          : const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                      child: Image.memory(image),
                                    ),
                                    widget.currentPageWidget!(pageNumber, isCurrentPage),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return widget.loadingIndicator!;
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void swipeToPage(int page, int itemCount) {
    final contentSize = controller.position.viewportDimension + controller.position.maxScrollExtent;
    final index = page - 1;
    final target = contentSize * index / itemCount;
    controller.animateTo(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

Future<Map<int, Uint8List>> _render(
  String filePath,
  ImageThumbnailCacher? cacher,
) async {
  final images = <int, Uint8List>{};
  try {
    if (cacher != null) {
      final cached = await cacher.read(filePath);
      if (cached != null && cached.isNotEmpty) {
        return cached;
      }
    }
    final document = await PdfDocument.openFile(filePath);

    for (var pageNumber = 1; pageNumber <= document.pagesCount; pageNumber++) {
      final page = await document.getPage(pageNumber);
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
  if (cacher != null) {
    await cacher.write(id: filePath, map: images);
  }
  return images;
}

/// Interface for caching thumbnails
abstract class ImageThumbnailCacher {
  /// Read from cache
  Future<PageToImage?> read(String id);

  /// Write to cache
  Future<bool> write({
    required String id,
    required PageToImage map,
  });
}

/// Page to image map
typedef PageToImage = Map<int, Uint8List>;

Map<int?, Uint8List?> filter(int? myVar, SplayTreeMap<int?, Uint8List?> values) {
  if (values.containsKey(myVar)) {
    return {myVar: values[myVar]};
  }

  int lowerKey = values.lastKeyBefore(myVar)!;
  int upperKey = values.firstKeyAfter(myVar)!;

  return {
    lowerKey: values[lowerKey],
    upperKey: values[upperKey],
  };
}
