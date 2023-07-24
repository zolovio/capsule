import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/constants/dimensions.dart';
import '../core/constants/palette.dart';
import 'custom_button.dart';
import 'custom_divider.dart';
import 'custom_text.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.cardColor,
    required this.radius,
    required this.padding,
    this.image,
    required this.width,
    required this.text,
    required this.fontWeight,
    required this.fontSize,
    required this.textColor,
    this.height = 1.5,
    this.textAlign = TextAlign.center,
    this.dividerHeight,
    this.isDivider = false,
    this.buttonText,
    this.buttonFontWeight,
    this.buttonFontSize,
    this.buttonPadding = 0,
    this.buttonWidth,
    this.buttonHeight,
    this.buttonRadius,
    this.buttonColor,
    this.buttonTextColor,
    this.buttonBorderColor,
    this.borderColor,
    this.paddingHorizontal,
    this.paddingVertical,
    this.options,
    required this.onPressed,
    this.isVertical = false,
    this.isOptions = false,
  }) : super(key: key);

  final Color cardColor;
  final double radius;
  final double padding;
  final String? image;
  final double width;
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color textColor;
  final double height;
  final TextAlign? textAlign;
  final double? dividerHeight;
  final bool? isDivider;
  final String? buttonText;
  final FontWeight? buttonFontWeight;
  final double? buttonFontSize;
  final double? buttonPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? buttonRadius;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Color? buttonBorderColor;
  final Color? borderColor;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final List<String>? options;
  final Function onPressed;
  final bool isVertical;
  final bool isOptions;

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? InkWell(
            onTap: () => onPressed(),
            child: Card(
              elevation: 0,
              color: cardColor,
              margin: EdgeInsets.all(padding),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: BorderSide(color: buttonBorderColor!),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: image!,
                    fit: BoxFit.contain,
                    height: height,
                    placeholder: (context, url) => Icon(
                      Icons.cloud_download_rounded,
                      color: AppColors.pinkFillColor,
                      size: height,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: AppColors.redColor.withOpacity(0.5),
                      size: height,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: CustomText(
                      text: text,
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                      textColor: textColor,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          )
        : isOptions
            ? Card(
                elevation: 0,
                color: cardColor,
                margin: EdgeInsets.all(padding),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                  side: BorderSide(color: borderColor!),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: paddingHorizontal!, vertical: paddingVertical!),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: text,
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                        textColor: textColor,
                      ),
                      CustomDivider(height: height, isDivider: false),
                      CustomText(
                        text: buttonText!,
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                        textColor: textColor,
                      ),
                      CustomDivider(height: height, isDivider: false),
                      Column(
                        children: options!
                            .map<Widget>(
                              (e) => InkWell(
                                onTap: () => onPressed(),
                                child: Card(
                                  elevation: 0,
                                  color: cardColor,
                                  margin: EdgeInsets.all(padding),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(radius),
                                    side: BorderSide(color: borderColor!),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(margin_10),
                                    child: CustomText(
                                      text: e,
                                      fontWeight: buttonFontWeight!,
                                      fontSize: buttonFontSize!,
                                      textColor: buttonTextColor!,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              )
            : Card(
                color: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Row(
                    children: [
                      Image.asset(image!, width: width),
                      Expanded(
                        child: Column(
                          children: [
                            CustomText(
                              text: text,
                              fontWeight: fontWeight,
                              fontSize: fontSize,
                              textColor: textColor,
                              height: 1.5,
                              textAlign: TextAlign.center,
                            ),
                            CustomDivider(height: dividerHeight!, isDivider: isDivider!),
                            CustomButton(
                              title: buttonText!,
                              fontWeight: buttonFontWeight!,
                              fontSize: buttonFontSize!,
                              horizontalPadding: buttonPadding,
                              minimumWidth: buttonWidth,
                              minimumHeight: buttonHeight,
                              radius: buttonRadius,
                              backgroundColor: buttonColor,
                              textColor: buttonTextColor!,
                              borderColor: buttonBorderColor,
                              onPressed: () => onPressed(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}
