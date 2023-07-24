import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    required this.fontWeight,
    required this.fontSize,
    required this.textColor,
    this.textAlign = TextAlign.start,
    this.overflow,
    this.height = 1,
    this.maxLines,
    this.isRichText = false,
    this.childText,
    this.childFontWeight,
    this.childFontSize,
    this.childTextColor,
    this.onTap,
  }) : super(key: key);

  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color textColor;
  final TextAlign textAlign;
  final double height;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? childText;
  final FontWeight? childFontWeight;
  final double? childFontSize;
  final Color? childTextColor;
  final Function? onTap;
  final bool isRichText;

  @override
  Widget build(BuildContext context) {
    return !isRichText
        ? Text(
            text,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor,
              height: height,
            ),
          )
        : RichText(
            text: TextSpan(
              text: text,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
                height: height,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: childText,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: childFontSize,
                      fontWeight: childFontWeight,
                      color: childTextColor,
                      height: height,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () => onTap!()),
              ],
            ),
          );
  }
}
