import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../core/constants/palette.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    required this.name,
    this.initialValue,
    required this.labelText,
    this.textColor = AppColors.black,
    required this.fontSize,
    required this.fontWeight,
    this.borderColor = AppColors.pinkGrade1,
    this.borderWidth = 1,
    required this.radius,
    required this.formBuilderValidators,
    required this.inputType,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.fillColor = AppColors.pinkGrade2,
    this.labelColor = AppColors.black,
    this.isCollapsed = false,
    this.maxLines = 1,
    this.alignLabelWithHint = false,
    this.textInputType = TextInputType.text,
  });

  final TextEditingController? controller;
  final AutovalidateMode autoValidateMode;
  final String name;
  final String? initialValue;
  final String labelText;
  final Color labelColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final List<String? Function(String?)> formBuilderValidators;
  final TextInputType inputType;
  final dynamic suffixIcon;
  final Icon? prefixIcon;
  final Function? onTap;
  final Color fillColor;
  final bool isCollapsed;
  final int maxLines;
  final bool alignLabelWithHint;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      name: name,
      initialValue: initialValue,
      cursorColor: AppColors.black,
      textAlignVertical: TextAlignVertical.top,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
        fontFamily: 'OpenSans',
      ),
      decoration: InputDecoration(
        filled: true,
        alignLabelWithHint: alignLabelWithHint,
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: labelColor,
          fontFamily: 'OpenSans',
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: fillColor,
        isCollapsed: isCollapsed,
        // contentPadding: EdgeInsets.symmetric(vertical: contentPadding!),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onChanged: (val) {},
      validator: FormBuilderValidators.compose(formBuilderValidators),
      keyboardType: textInputType,
    );
  }
}
