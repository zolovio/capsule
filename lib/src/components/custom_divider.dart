import 'package:flutter/material.dart';

import '../core/constants/dimensions.dart';
import '../core/constants/font_weight.dart';
import '../core/constants/palette.dart';
import 'custom_text.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
    this.height,
    this.width = 0,
    this.color,
    this.padding,
    this.isDivider = false,
    this.isVerticalDivider = false,
    this.text,
  }) : super(key: key);

  final double? height;
  final double? width;
  final Color? color;
  final String? text;
  final double? padding;
  final bool isDivider;
  final bool isVerticalDivider;

  @override
  Widget build(BuildContext context) {
    return isDivider
        ? Row(
            children: [
              Expanded(
                child: Divider(height: height, color: color),
              ),
              CustomText(
                text: text!,
                fontWeight: fontWeight400,
                fontSize: font_15,
                textColor: AppColors.black,
              ),
              Expanded(
                child: Divider(height: height, color: color),
              ),
            ],
          )
        : isVerticalDivider
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: padding!),
                child: VerticalDivider(color: color, width: width),
              )
            : SizedBox(height: height, width: width);
  }
}
