import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    required this.fontWeight,
    required this.fontSize,
    this.horizontalPadding = 0,
    this.minimumWidth,
    this.minimumHeight,
    this.radius,
    this.backgroundColor,
    required this.textColor,
    this.borderColor,
    required this.onPressed,
    this.icon,
    this.isTextButton = false,
    this.isLoading = false,
  }) : super(key: key);

  final String title;
  final FontWeight fontWeight;
  final double? horizontalPadding;
  final double fontSize;
  final double? minimumWidth;
  final double? minimumHeight;
  final double? radius;
  final Color? backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final void Function() onPressed;
  final dynamic icon;
  final bool isTextButton;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isTextButton
        ? TextButton(
            onPressed: () => onPressed(),
            child: CustomText(
              text: title,
              fontWeight: fontWeight,
              fontSize: fontSize,
              textColor: textColor,
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding!),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: backgroundColor,
                fixedSize: Size(minimumWidth!, minimumHeight!),
                minimumSize: Size(minimumWidth!, minimumHeight!),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1, // thickness
                    color: borderColor!,
                  ),
                  borderRadius: BorderRadius.circular(radius!),
                ),
              ),
              onPressed: () => onPressed(),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: textColor),
                    )
                  : Row(
                      children: [
                        icon ?? Container(),
                        Expanded(
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: fontWeight,
                              fontSize: fontSize,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          );
  }
}
