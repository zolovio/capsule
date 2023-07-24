// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_card.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_icon.dart';
import '../../../components/custom_list_tile.dart';
import '../../../components/custom_shaded_text.dart';
import '../../../components/custom_spdf_viewer/custom_spdf_viewer.dart';
import '../../../components/custom_text.dart';
import '../../../components/custom_textfield.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'dashboard_controller.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_10),
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: radius_25,
                      backgroundColor: AppColors.white,
                      child: Image.asset(ImgAssets.userProf),
                    ),
                    CustomDivider(
                      height: height_0,
                      width: width_8,
                      isDivider: false,
                    ),
                    CustomShadedText(
                      text: "Hello, Danish",
                      fontWeight: fontWeight600,
                      fontSize: font_16,
                      textColor: AppColors.pinkGrade2,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomIcon(
                      image: ImgAssets.heart,
                      imageColor: AppColors.white,
                      containerColor: AppColors.pinkGrade2,
                      margin: margin_6,
                    ),
                    CustomDivider(
                      height: height_0,
                      width: width_10,
                      isDivider: false,
                    ),
                    CustomIcon(
                      image: ImgAssets.bell,
                      imageColor: AppColors.white,
                      containerColor: AppColors.pinkGrade2,
                      margin: margin_6,
                    ),
                  ],
                ),
              ),
            ],
          ),
          CustomDivider(
            height: height_20,
            isDivider: false,
          ),
          FormBuilder(
            child: CustomTextField(
              name: 'search',
              labelText: strSearchPlace,
              labelColor: AppColors.pinkGrade2,
              fontSize: font_14,
              fontWeight: fontWeight400,
              formBuilderValidators: const [],
              inputType: TextInputType.text,
              radius: radius_40,
              fillColor: AppColors.pinkFillColor,
              borderColor: AppColors.pinkGrade2,
              isCollapsed: true,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.pinkGrade2,
              ),
              suffixIcon: const Icon(
                Icons.filter_list_outlined,
                color: AppColors.pinkGrade2,
              ),
            ),
          ),
          CustomDivider(
            height: height_20,
            isDivider: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: margin_5),
            child: CustomText(
              text: strPromotion,
              fontWeight: fontWeight600,
              fontSize: font_16,
              textColor: AppColors.black,
              height: 1.5,
            ),
          ),
          CustomDivider(
            height: height_10,
            isDivider: false,
          ),
          CustomCard(
            cardColor: AppColors.pinkGrade2,
            radius: radius_20,
            padding: margin_15,
            image: ImgAssets.backPoster,
            width: width_170,
            text: "Explore Your Knowledge With Us",
            fontWeight: fontWeight600,
            fontSize: font_17,
            textColor: AppColors.white,
            height: 1.5,
            textAlign: TextAlign.center,
            dividerHeight: height_10,
            buttonText: "Try it",
            buttonFontWeight: fontWeight600,
            buttonFontSize: font_13,
            buttonWidth: width_70,
            buttonHeight: height_30,
            buttonRadius: radius_50,
            buttonColor: AppColors.blueGrade2,
            buttonTextColor: AppColors.white,
            buttonBorderColor: AppColors.blueGrade2,
            onPressed: () {},
          ),
          CustomDivider(
            height: height_15,
            isDivider: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: margin_5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: strAwesomeSubjects,
                  fontWeight: fontWeight600,
                  fontSize: font_16,
                  textColor: AppColors.black,
                  height: 1.5,
                ),
                CustomButton(
                  title: strSeeAll,
                  fontWeight: fontWeight400,
                  fontSize: font_13,
                  textColor: AppColors.pinkGrade2,
                  onPressed: controller.handleSubjectNavigation,
                  isTextButton: true,
                ),
              ],
            ),
          ),
          CustomDivider(
            height: height_5,
            isDivider: false,
          ),
          Obx(
            () => controller.subjectsController.isLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    height: height_30,
                    margin: EdgeInsets.only(bottom: margin_5),
                    child: ListView.builder(
                      itemCount: controller.subjectsController.classes.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Obx(
                              () => CustomButton(
                                title: controller.subjectsController.classes[index].className!,
                                fontWeight: fontWeight700,
                                fontSize: font_14,
                                horizontalPadding: margin_0,
                                minimumWidth: width_90,
                                minimumHeight: height_30,
                                radius: radius_40,
                                backgroundColor:
                                    index == controller.subjectsController.selectedIndex.value
                                        ? AppColors.pinkGrade2
                                        : AppColors.blueGrade2,
                                textColor: AppColors.white,
                                borderColor: AppColors.transparent,
                                onPressed: index ==
                                        controller.subjectsController.selectedIndex.value
                                    ? () {}
                                    : () => controller.onToggleSelected(
                                        index, controller.subjectsController.classes[index].id!),
                              ),
                            ),
                            CustomDivider(height: height_0, width: width_5, isDivider: false),
                          ],
                        );
                      },
                    ),
                  ),
          ),
          Obx(
            () => controller.subjectsController.isLoadSubjects.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    height: controller.subjectsController.subjects.length <= 3
                        ? height_135
                        : height_225,
                    padding: EdgeInsets.symmetric(vertical: margin_10),
                    child: GridView.count(
                      crossAxisCount: 3,
                      physics: const NeverScrollableScrollPhysics(),
                      children: controller.subjectsController.subjects
                          .map(
                            (subject) => CustomCard(
                              cardColor: AppColors.pinkFillColor,
                              radius: radius_15,
                              padding: margin_5,
                              image: subject.subjectPicture,
                              width: width_170,
                              text: subject.subjectName!,
                              fontWeight: fontWeight700,
                              fontSize: font_17,
                              textColor: AppColors.pinkGrade2,
                              height: height_50,
                              textAlign: TextAlign.center,
                              buttonBorderColor: AppColors.pinkGrade2,
                              onPressed: () {},
                              isVertical: true,
                            ),
                          )
                          .toList(),
                    ),
                  ),
          ),
          CustomDivider(
            height: height_5,
            isDivider: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: margin_5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: strPopularBooks,
                  fontWeight: fontWeight600,
                  fontSize: font_16,
                  textColor: AppColors.black,
                  height: 1.5,
                ),
                CustomButton(
                  title: strSeeAll,
                  fontWeight: fontWeight400,
                  fontSize: font_13,
                  textColor: AppColors.pinkGrade2,
                  onPressed: controller.handleBookNavigation,
                  isTextButton: true,
                ),
              ],
            ),
          ),
          Container(
            height: height_170,
            padding: EdgeInsets.symmetric(vertical: margin_5),
            child: Obx(
              () => controller.booksController.isLoading.isTrue
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.booksController.booksList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Get.to(
                            () => CustomSPDFViewer(
                              title: controller.booksController.booksList[index].bookName!,
                              pdfNetworkLink:
                                  controller.booksController.booksList[index].ebookPdfUrl!,
                            ),
                            arguments: [
                              controller.booksController.booksList[index].ebookPdfUrl!,
                              controller.booksController.booksList[index].bookName!,
                            ],
                          ),
                          child: CustomContainer(
                            margin: margin_5,
                            borderColor: AppColors.greyColor.withOpacity(0.3),
                            radius: radius_15,
                            image: controller.booksController.booksList[index].bookIconUrl,
                            width: width_90,
                            height: height_120,
                            paddingHorizontal: margin_10,
                            paddingVertical: margin_5,
                            text: controller.booksController.booksList[index].bookName!,
                            fontWeight: fontWeight600,
                            fontSize: font_13,
                            textColor: AppColors.black,
                            isNetworkImage: true,
                          ),
                        );
                      },
                    ),
            ),
          ),
          CustomDivider(
            height: height_5,
            isDivider: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: margin_5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: strRecentResults,
                  fontWeight: fontWeight600,
                  fontSize: font_17,
                  textColor: AppColors.black,
                  height: 1.5,
                ),
                CustomButton(
                  title: strSeeAll,
                  fontWeight: fontWeight400,
                  fontSize: font_13,
                  textColor: AppColors.pinkGrade2,
                  onPressed: controller.handleSeeAllHistoryNavigation,
                  isTextButton: true,
                ),
              ],
            ),
          ),
          Obx(
            () => controller.examHistoryController.isLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: controller.examHistoryController.examHistory.getRange(0, 3).map(
                      (result) {
                        Color color =
                            (controller.examHistoryController.examHistory.indexOf(result) + 1) %
                                        2 ==
                                    0
                                ? AppColors.blueGrade2
                                : AppColors.pinkGrade2;

                        return CustomListTile(
                          margin: margin_5,
                          tileColor: color,
                          radius: radius_15,
                          avatarColor: AppColors.white,
                          leadingText:
                              (controller.examHistoryController.examHistory.indexOf(result) + 1)
                                  .toString(),
                          leadingFontWeight: fontWeight700,
                          leadingFontSize: font_16,
                          leadingTextColor: AppColors.black,
                          titleText: result.chapterName!,
                          titleFontWeight: fontWeight700,
                          titleFontSize: font_14,
                          titleTextColor: AppColors.white,
                          lineHeight: height_5,
                          percent: result.marksScored! / result.totalQuestions!,
                          indicatorColor: AppColors.white,
                          progressColor:
                              (controller.examHistoryController.examHistory.indexOf(result) + 1) %
                                          2 ==
                                      1
                                  ? AppColors.blueGrade2
                                  : AppColors.pinkGrade2,
                          trailingText: "${result.marksScored}/${result.totalQuestions}",
                          trailingFontWeight: fontWeight700,
                          trailingFontSize: font_16,
                          trailingTextColor: AppColors.white,
                          onTap: controller.handleHistoryNavigation,
                        );
                      },
                    ).toList(),
                  ),
          ),
          CustomDivider(height: height_20),
        ],
      ),
    );
  }
}
