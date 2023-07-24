import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/assets.dart';
import '../core/constants/dimensions.dart';
import '../core/constants/font_weight.dart';
import '../core/constants/palette.dart';
import 'custom_container.dart';
import 'custom_icon.dart';
import 'custom_shaded_text.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    Key? key,
    required this.appBar,
    this.text,
    this.fontWeight,
    this.fontSize,
    this.textColor,
    this.isEmptyTitle = true,
    this.image,
    this.imageColor,
    this.containerColor,
    this.margin,
    this.width,
    this.height,
    this.radius,
    this.isCenter = false,
    this.isLeading = true,
    this.isTimer = false,
  }) : super(key: key);

  final AppBar appBar;
  final String? text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  final String? image;
  final Color? imageColor;
  final Color? containerColor;
  final double? margin;
  final double? width;
  final double? height;
  final double? radius;
  final bool isCenter;
  final bool isLeading;
  final bool isEmptyTitle;
  final bool isTimer;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: isLeading,
      centerTitle: isCenter,
      leading: isLeading
          ? IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: AppColors.pinkGrade2,
              ),
            )
          : null,
      title: isEmptyTitle
          ? null
          : isTimer
              ? CustomContainer(
                  margin: margin_5,
                  borderColor: AppColors.greyColor.withOpacity(0.3),
                  radius: radius_10,
                  image: ImgAssets.clock,
                  width: width_100,
                  height: height_35,
                  paddingHorizontal: margin_10,
                  paddingVertical: margin_5,
                  text: text!,
                  fontWeight: fontWeight600,
                  fontSize: font_13,
                  textColor: AppColors.white,
                  containerColor: AppColors.pinkGrade2,
                  isTimer: true,
                )
              : image != null
                  ? Row(
                      mainAxisAlignment:
                          isCenter ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                      children: [
                        CustomShadedText(
                          text: text!,
                          fontWeight: fontWeight!,
                          fontSize: fontSize!,
                          textColor: textColor!,
                        ),
                        if (image != null) ...[
                          CustomIcon(
                            image: image!,
                            imageColor: imageColor!,
                            containerColor: containerColor!,
                            margin: margin!,
                          ),
                        ],
                      ],
                    )
                  : CustomShadedText(
                      text: text!,
                      fontWeight: fontWeight!,
                      fontSize: fontSize!,
                      textColor: textColor!,
                      overflow: TextOverflow.ellipsis,
                    ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
