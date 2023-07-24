import 'package:flutter/cupertino.dart';

import '../core/constants/palette.dart';

class CustomShadedText extends StatelessWidget {
  const CustomShadedText({
    Key? key,
    required this.text,
    this.textAlignment = TextAlign.start,
    required this.fontWeight,
    required this.fontSize,
    required this.textColor,
    this.textAlign = TextAlign.start,
    this.height = 1,
    this.overflow,
  }) : super(key: key);

  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color textColor;
  final TextAlign textAlign;
  final double height;
  final TextAlign textAlignment;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.pinkGrade1, AppColors.pinkGrade2],
        ).createShader(bounds);
      },
      child: Text(
        text,
        textAlign: textAlignment,
        overflow: overflow,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    );
  }
}
