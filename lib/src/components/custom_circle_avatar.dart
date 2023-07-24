import 'package:flutter/material.dart';

import 'custom_divider.dart';
import 'custom_text.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    Key? key,
    required this.radius,
    required this.radius1,
    required this.radius2,
    required this.backgroundColor,
    required this.backgroundColor1,
    required this.backgroundColor2,
    required this.titleText,
    required this.titleFontWeight,
    required this.titleFontSize,
    required this.titleColor,
    required this.scoreText,
    required this.scoreFontWeight,
    required this.scoreFontSize,
    required this.scoreColor,
    required this.subTitleText,
    required this.subTitleFontWeight,
    required this.subTitleFontSize,
    required this.subTitleColor,
    required this.height,
  }) : super(key: key);

  final double radius;
  final double radius1;
  final double radius2;
  final Color backgroundColor;
  final Color backgroundColor1;
  final Color backgroundColor2;
  final String titleText;
  final FontWeight titleFontWeight;
  final double titleFontSize;
  final Color titleColor;
  final String scoreText;
  final FontWeight scoreFontWeight;
  final double scoreFontSize;
  final Color scoreColor;
  final String subTitleText;
  final FontWeight subTitleFontWeight;
  final double subTitleFontSize;
  final Color subTitleColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: CircleAvatar(
        radius: radius1,
        backgroundColor: backgroundColor1,
        child: CircleAvatar(
          radius: radius2,
          backgroundColor: backgroundColor2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: titleText,
                fontWeight: titleFontWeight,
                fontSize: titleFontSize,
                textColor: titleColor,
              ),
              CustomDivider(height: height, isDivider: false),
              CustomText(
                text: scoreText,
                fontWeight: scoreFontWeight,
                fontSize: scoreFontSize,
                textColor: scoreColor,
              ),
              CustomDivider(height: height, isDivider: false),
              CustomText(
                text: subTitleText,
                fontWeight: subTitleFontWeight,
                fontSize: subTitleFontSize,
                textColor: subTitleColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
