import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/assets.dart';
import '../core/constants/dimensions.dart';
import '../core/constants/font_weight.dart';
import '../core/constants/palette.dart';
import '../core/constants/strings.dart';
import 'custom_button.dart';
import 'custom_divider.dart';
import 'custom_shaded_text.dart';
import 'custom_text.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius_30),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: margin_8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Image.asset(ImgAssets.closesQr),
                ),
              ],
            ),
          ),
          CustomShadedText(
            text: strLogout,
            fontWeight: fontWeight600,
            fontSize: font_25,
            textColor: AppColors.pinkGrade2,
          ),
          CustomDivider(height: height_15),
          CustomText(
            text: "Are you sure want to log out?",
            fontWeight: fontWeight400,
            fontSize: font_12,
            textColor: AppColors.greyColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: margin_25, vertical: margin_15),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: strCancel,
                    fontWeight: fontWeight600,
                    fontSize: font_15,
                    horizontalPadding: margin_0,
                    minimumWidth: width_30,
                    minimumHeight: height_35,
                    radius: radius_40,
                    backgroundColor: AppColors.blueGrade2,
                    textColor: AppColors.white,
                    borderColor: AppColors.blueGrade2,
                    onPressed: () => Get.back(),
                  ),
                ),
                CustomDivider(width: height_15),
                Expanded(
                  child: CustomButton(
                    title: strLogout,
                    fontWeight: fontWeight600,
                    fontSize: font_15,
                    horizontalPadding: margin_0,
                    minimumWidth: width_0,
                    minimumHeight: height_35,
                    radius: radius_40,
                    backgroundColor: AppColors.pinkGrade2,
                    textColor: AppColors.white,
                    borderColor: AppColors.pinkGrade2,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: margin_5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool? value) {},
                  side: const BorderSide(color: AppColors.pinkGrade2, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius_5),
                  ),
                ),
                CustomText(
                  text: "Delete account permanent",
                  fontWeight: fontWeight400,
                  fontSize: font_12,
                  textColor: AppColors.black,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
