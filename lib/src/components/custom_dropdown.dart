import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../core/constants/palette.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    required this.name,
    this.initialValue,
    required this.labelText,
    this.labelColor = AppColors.black,
    this.textColor = AppColors.black,
    required this.fontSize,
    required this.fontWeight,
    required this.borderColor,
    this.borderWidth = 1,
    required this.radius,
    required this.inputType,
    this.suffixIcon,
    this.prefixIcon,
    required this.icon,
    required this.onChanged,
    this.fillColor = AppColors.pinkGrade2,
    required this.options,
    required this.formBuilderValidators,
  }) : super(key: key);

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
  final TextInputType inputType;
  final dynamic suffixIcon;
  final Icon? prefixIcon;
  final Icon? icon;
  final Function(String)? onChanged;
  final Color fillColor;
  final List<String> options;
  final String? Function(String?) formBuilderValidators;

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<String>(
      name: name,
      icon: icon,
      validator: formBuilderValidators,
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: labelColor,
          fontFamily: 'OpenSans',
        ),
        hintText: labelText,
        hintStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: labelColor,
          fontFamily: 'OpenSans',
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: fillColor,
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
      initialValue: initialValue,
      items: options
          .map(
            (option) => DropdownMenuItem(
              alignment: AlignmentDirectional.topStart,
              value: option,
              child: Text(
                option,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: textColor,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (val) => onChanged!(val!),
      valueTransformer: (val) => val?.toString(),
    );
  }
}
