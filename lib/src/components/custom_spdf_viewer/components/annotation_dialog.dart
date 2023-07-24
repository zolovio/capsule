// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';

import '../controllers/annotation_controller.dart';
import 'pdf_thumbnail.dart';

class AnnotationDialog extends StatelessWidget {
  AnnotationDialog({Key? key}) : super(key: key);

  AnnotationController controller = Get.put(AnnotationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
            title: TabBar(
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorPadding: const EdgeInsets.only(left: 0, bottom: 1),
              unselectedLabelColor: const Color(0xFFAF51BF),
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              indicator: ShapeDecoration(
                color: const Color(0xFFAF51BF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              ),
              onTap: (index) => controller.updateIndex(index),
              tabs: [
                Tab(
                  iconMargin: EdgeInsets.zero,
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(color: const Color(0xFFAF51BF), width: 2),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Highlights",
                        style: TextStyle(
                          color: controller.currentIndex.value == 0 ? Colors.white : Colors.purple,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  iconMargin: EdgeInsets.zero,
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(color: const Color(0xFFAF51BF), width: 2),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Bookmarks",
                        style: TextStyle(
                          color: controller.currentIndex.value == 1 ? Colors.white : Colors.purple,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              indicatorWeight: 0,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              controller.isLoading.isTrue
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: controller.highlights.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                          child: Column(
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
                                          int.parse(controller.highlights[index]["page"]) < 10
                                              ? "PAGE 0${controller.highlights[index]["page"]}"
                                              : "PAGE ${controller.highlights[index]["page"]}",
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
                                  if (index == 0) ...[
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        icon: const Icon(Icons.more_vert),
                                        onChanged: (String? newValue) {
                                          controller.dropdownValue = newValue!;
                                        },
                                        items: <String>[
                                          'Filter',
                                          'Starred',
                                          'All Highlights',
                                          'Yellow Highlights',
                                          'Green Highlights',
                                          'Blue Highlights',
                                          'Pink Highlights',
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
                                                                MediaQuery.of(context).size.width /
                                                                    3,
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
                                                            enabledTrackColor:
                                                                Colors.purple.shade400,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                  if (value != "Filter" && value != "Starred") ...[
                                                    if (value == "All Highlights") ...[
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
                                                              " (${controller.highlights.length.toString()})",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors.grey.shade400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                    if (value == "Yellow Highlights") ...[
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 15.0),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 25,
                                                              height: 25,
                                                              margin:
                                                                  const EdgeInsets.only(right: 8.0),
                                                              decoration: BoxDecoration(
                                                                color: Colors.yellow.shade300,
                                                                shape: BoxShape.circle,
                                                              ),
                                                            ),
                                                            Text(
                                                              value,
                                                              style: const TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              " (${controller.highlights.where((e) => e["color"] == "yellow").length.toString()})",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors.grey.shade400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                    if (value == "Green Highlights") ...[
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 15.0),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 25,
                                                              height: 25,
                                                              margin:
                                                                  const EdgeInsets.only(right: 8.0),
                                                              decoration: BoxDecoration(
                                                                color: Colors.green.shade300,
                                                                shape: BoxShape.circle,
                                                              ),
                                                            ),
                                                            Text(
                                                              value,
                                                              style: const TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              " (${controller.highlights.where((e) => e["color"] == "green").length.toString()})",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors.grey.shade400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                    if (value == "Blue Highlights") ...[
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 15.0),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 25,
                                                              height: 25,
                                                              margin:
                                                                  const EdgeInsets.only(right: 8.0),
                                                              decoration: BoxDecoration(
                                                                color: Colors.blueAccent.shade100,
                                                                shape: BoxShape.circle,
                                                              ),
                                                            ),
                                                            Text(
                                                              value,
                                                              style: const TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              " (${controller.highlights.where((e) => e["color"] == "blue").length.toString()})",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors.grey.shade400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                    if (value == "Pink Highlights") ...[
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 15.0),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 25,
                                                              height: 25,
                                                              margin:
                                                                  const EdgeInsets.only(right: 8.0),
                                                              decoration: BoxDecoration(
                                                                color: Colors.pinkAccent.shade100,
                                                                shape: BoxShape.circle,
                                                              ),
                                                            ),
                                                            Text(
                                                              value,
                                                              style: const TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              " (${controller.highlights.where((e) => e["color"] == "pink").length.toString()})",
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
                                ],
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: VerticalDivider(
                                        color: controller.highlights[index]["color"] == "yellow"
                                            ? Colors.yellow.shade300
                                            : controller.highlights[index]["color"] == "blue"
                                                ? Colors.blueAccent.shade100
                                                : controller.highlights[index]["color"] == "green"
                                                    ? Colors.green.shade300
                                                    : controller.highlights[index]["color"] ==
                                                            "pink"
                                                        ? Colors.pinkAccent.shade100
                                                        : Colors.black45,
                                        thickness: 5,
                                        width: 5,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 18.0, right: 20),
                                        child: Text(
                                          controller.highlights[index]["text"].trim(),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              controller.isLoading.isTrue
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      children: controller.bookmarks
                          .map(
                            (element) => PdfThumbnail.fromFile(
                              controller.pdfController.filePath!.value,
                              currentPage: element,
                              count: 1,
                              filters: controller.filters,
                              backgroundColor: Colors.white,
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
                                controller.pdfController.currentPage.value = page + 1;

                                controller.pdfController.showGrid!.toggle();

                                controller.pdfController.pdfViewerController.jumpToPage(page + 1);
                              },
                            ),
                          )
                          .toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
