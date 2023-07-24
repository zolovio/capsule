import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../core/constants/palette.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    required this.name,
    this.initialValue,
    required this.labelText,
    required this.labelColor,
    this.textColor = AppColors.black,
    required this.fontSize,
    required this.fontWeight,
    required this.borderColor,
    required this.borderWidth,
    required this.radius,
    required this.formBuilderValidators,
    required this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
  });

  final AutovalidateMode autoValidateMode;
  final String name;
  final DateTime? initialValue;
  final String labelText;
  final Color labelColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final List<String? Function(DateTime?)> formBuilderValidators;
  final dynamic suffixIcon;
  final Icon? prefixIcon;
  final Function? onTap;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: name,
      initialValue: initialValue,
      autovalidateMode: autoValidateMode,
      initialEntryMode: DatePickerEntryMode.calendar,
      inputType: InputType.date,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
        fontFamily: 'OpenSans',
      ),
      decoration: InputDecoration(
        filled: true,
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
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
    );
  }
}
