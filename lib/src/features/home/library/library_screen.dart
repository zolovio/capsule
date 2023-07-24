// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_text.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'library_controller.dart';

class LibraryScreen extends StatelessWidget {
  LibraryScreen({Key? key}) : super(key: key);

  LibraryController controller = Get.put(LibraryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        appBar: AppBar(),
        text: strViewLibrary,
        fontWeight: fontWeight600,
        fontSize: font_20,
        textColor: AppColors.pinkGrade2,
        isEmptyTitle: false,
        isLeading: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_15),
        children: controller.libraryList
            .map<Widget>(
              (library) => Card(
                elevation: 0,
                color: AppColors.pinkFillColor,
                margin: EdgeInsets.symmetric(vertical: margin_8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius_15),
                  side: const BorderSide(
                    color: AppColors.pinkGrade2,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(margin_10),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: library.bookIconUrl!,
                          fit: BoxFit.fill,
                          height: height_100,
                          width: width_90,
                          placeholder: (context, url) => Icon(
                            Icons.cloud_download_rounded,
                            color: AppColors.pinkFillColor,
                            size: height_100,
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: AppColors.redColor.withOpacity(0.5),
                            size: height_100,
                          ),
                        ),
                        CustomDivider(
                          width: width_2,
                          color: AppColors.pinkGrade2,
                          isVerticalDivider: true,
                          padding: margin_10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LimitedBox(
                              maxWidth: MediaQuery.of(context).size.width * 0.54,
                              child: CustomText(
                                text: library.bookName!,
                                fontWeight: fontWeight600,
                                fontSize: font_16,
                                textColor: AppColors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            CustomDivider(height: height_8),
                            LimitedBox(
                              maxWidth: MediaQuery.of(context).size.width * 0.54,
                              child: CustomText(
                                text: library.bookDescription!,
                                fontWeight: fontWeight400,
                                fontSize: font_11,
                                textColor: AppColors.greyColor,
                                maxLines: 4,
                                textAlign: TextAlign.justify,
                                childText: " $strReadMore ...",
                                childFontWeight: fontWeight400,
                                childFontSize: font_11,
                                childTextColor: AppColors.pinkGrade2,
                                height: 1.5,
                                onTap: () {},
                                isRichText: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
