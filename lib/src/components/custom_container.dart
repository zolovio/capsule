import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/constants/palette.dart';
import 'custom_divider.dart';
import 'custom_text.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.margin,
    this.borderColor,
    required this.radius,
    this.image,
    this.width,
    this.height,
    this.paddingHorizontal,
    this.paddingVertical,
    required this.text,
    required this.fontWeight,
    required this.fontSize,
    required this.textColor,
    this.containerColor,
    this.boxShadow,
    this.isTimer = false,
    this.isResult = false,
    this.subText,
    this.subFontWeight,
    this.subFontSize,
    this.subTextColor,
    this.isNetworkImage = false,
  });

  final double? margin;
  final Color? borderColor;
  final double radius;
  final String? image;
  final double? width;
  final double? height;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color textColor;
  final String? subText;
  final FontWeight? subFontWeight;
  final double? subFontSize;
  final Color? subTextColor;
  final Color? containerColor;
  final Color? boxShadow;
  final bool isTimer;
  final bool isResult;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return isResult
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal!,
              vertical: paddingVertical!,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: containerColor,
                  radius: radius,
                ),
                CustomDivider(height: 0, width: width!, isDivider: false),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: text,
                      textColor: textColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                    if (subText != null) ...[
                      CustomDivider(height: height!, isDivider: false),
                      CustomText(
                        text: subText!,
                        textColor: subTextColor!,
                        fontSize: subFontSize!,
                        fontWeight: subFontWeight!,
                      ),
                    ],
                  ],
                )
              ],
            ),
          )
        : !isTimer
            ? Column(
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: isNetworkImage
                        ? Padding(
                            padding: EdgeInsets.all(paddingVertical!),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radius),
                              child: CachedNetworkImage(
                                imageUrl: image!,
                                fit: BoxFit.fill,
                                width: width,
                                height: height,
                                placeholder: (context, url) => Icon(
                                  Icons.cloud_download_rounded,
                                  color: AppColors.pinkFillColor,
                                  size: width,
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  color: AppColors.redColor.withOpacity(0.5),
                                  size: width,
                                ),
                              ),
                            ),
                          )
                        : Image.asset(
                            image!,
                            width: width,
                            height: height,
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: paddingHorizontal!, vertical: paddingVertical!),
                    child: CustomText(
                      text: "${text.substring(0, 12)}....",
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                      textColor: textColor,
                    ),
                  ),
                ],
              )
            : Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(image!),
                    CustomText(
                      text: text,
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                      textColor: textColor,
                    ),
                  ],
                ),
              );
  }
}
