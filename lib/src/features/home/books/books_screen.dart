// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_container.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'books_controller.dart';

class BooksScreen extends StatelessWidget {
  BooksScreen({Key? key}) : super(key: key);

  BooksController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        appBar: AppBar(),
        text: strBook,
        fontWeight: fontWeight600,
        fontSize: font_20,
        textColor: AppColors.pinkGrade2,
        isEmptyTitle: false,
      ),
      body: Obx(
        () => controller.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                itemCount: controller.booksList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return CustomContainer(
                    margin: margin_5,
                    borderColor: AppColors.greyColor.withOpacity(0.3),
                    radius: radius_15,
                    image: controller.booksList[index].bookIconUrl,
                    width: width_100,
                    height: height_120,
                    paddingHorizontal: margin_1,
                    paddingVertical: margin_5,
                    text: controller.booksList[index].bookName!,
                    fontWeight: fontWeight600,
                    fontSize: font_13,
                    textColor: AppColors.black,
                    isNetworkImage: true,
                  );
                },
              ),
      ),
    );
  }
}
