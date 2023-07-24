import 'package:flutter/material.dart';

import '../core/constants/constants.dart';
import '../core/constants/dimensions.dart';
import '../core/constants/palette.dart';
import 'custom_text.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    Key? key,
    required this.title,
    required this.titleFontSize,
    required this.titleFontWeight,
    required this.titleColor,
    this.backgroundColor = AppColors.white,
    this.margin,
    required this.padding,
    this.navTitle,
    this.navTitleFontSize,
    this.navTitleFontWeight,
    this.navTitleColor,
    required this.onTap,
    required this.bottomBarType,
    required this.height,
    this.width = double.infinity,
  }) : super(key: key);

  final String title;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final Color titleColor;
  final Color? backgroundColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String? navTitle;
  final double? navTitleFontSize;
  final FontWeight? navTitleFontWeight;
  final Color? navTitleColor;
  final Function onTap;
  final dynamic bottomBarType;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return bottomBarType == BottomBarType.button
        ? Container(
            width: width,
            height: height,
            padding: padding,
            margin: margin,
            child: ElevatedButton(
              onPressed: () => onTap(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius_25)),
                backgroundColor: backgroundColor,
              ),
              child: CustomText(
                text: title,
                fontWeight: titleFontWeight,
                fontSize: titleFontSize,
                textColor: titleColor,
              ),
            ),
          )
        : Padding(
            padding: padding!,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: title,
                  fontWeight: titleFontWeight,
                  fontSize: titleFontSize,
                  textColor: titleColor,
                ),
                SizedBox(width: width_5),
                InkWell(
                  onTap: () => onTap(),
                  child: Text(
                    navTitle!,
                    style: TextStyle(
                      fontSize: navTitleFontSize,
                      fontWeight: navTitleFontWeight,
                      color: navTitleColor,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
