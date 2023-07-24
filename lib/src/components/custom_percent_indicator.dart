import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'custom_text.dart';

class CustomPercentIndicator extends StatelessWidget {
  const CustomPercentIndicator({
    super.key,
    required this.radius,
    required this.lineWidth,
    required this.percent,
    required this.reverse,
    required this.startAngle,
    required this.animation,
    required this.animationDuration,
    required this.animateFromLastPercent,
    this.image,
    this.text,
    this.fontWeight,
    this.fontSize,
    this.textColor,
    required this.progressColor,
    required this.backgroundColor,
    this.isProfile = false,
  });

  final double radius;
  final double lineWidth;
  final double percent;
  final bool reverse;
  final double startAngle;
  final bool animation;
  final int animationDuration;
  final bool animateFromLastPercent;
  final String? image;
  final String? text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  final Color progressColor;
  final Color backgroundColor;
  final bool isProfile;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      percent: percent,
      reverse: reverse,
      startAngle: startAngle,
      animation: animation,
      animationDuration: animationDuration,
      animateFromLastPercent: animateFromLastPercent,
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      circularStrokeCap: CircularStrokeCap.round,
      center: isProfile
          ? Image.asset(image!)
          : CustomText(
              text: text!,
              fontWeight: fontWeight!,
              fontSize: fontSize!,
              textColor: textColor!,
            ),
    );
  }
}
