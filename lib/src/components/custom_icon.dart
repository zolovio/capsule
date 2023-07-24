import 'package:flutter/material.dart';

import '../core/constants/dimensions.dart';
import 'custom_divider.dart';
import 'custom_text.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    Key? key,
    required this.image,
    required this.imageColor,
    required this.containerColor,
    required this.margin,
    this.text,
    this.fontWeight,
    this.fontSize,
    this.textColor,
    this.onPressed,
  }) : super(key: key);

  final String image;
  final Color imageColor;
  final Color containerColor;
  final double margin;
  final String? text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed!(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(margin),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: containerColor,
            ),
            child: Image.asset(
              image,
              color: imageColor,
            ),
          ),
          if (text != null) ...[
            CustomDivider(height: height_12, isDivider: false),
            CustomText(
              text: text!,
              fontWeight: fontWeight!,
              fontSize: fontSize!,
              textColor: textColor!,
            ),
          ],
        ],
      ),
    );
  }
}
