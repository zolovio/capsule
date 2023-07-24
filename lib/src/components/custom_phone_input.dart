import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../core/constants/palette.dart';

class CustomPhoneInput extends StatelessWidget {
  const CustomPhoneInput({
    super.key,
    this.controller,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    required this.name,
    this.initialValue,
    required this.countryCode,
    required this.labelText,
    this.labelColor = AppColors.black,
    this.textColor = AppColors.black,
    required this.fontSize,
    required this.fontWeight,
    this.borderColor = AppColors.pinkGrade1,
    this.borderWidth = 1,
    required this.radius,
    this.readOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onSaved,
    this.onSubmitted,
    this.onCountryChanged,
    this.fillColor = AppColors.pinkGrade2,
    required this.flagsPadding,
  });

  final TextEditingController? controller;
  final AutovalidateMode autoValidateMode;
  final String name;
  final String? initialValue;
  final String countryCode;
  final String labelText;
  final Color labelColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final dynamic suffixIcon;
  final Icon? prefixIcon;
  final bool readOnly;
  final Function(PhoneNumber)? onChanged;
  final Function(PhoneNumber?)? onSaved;
  final Function(String)? onSubmitted;
  final Function(Country)? onCountryChanged;
  final Color fillColor;
  final double flagsPadding;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      initialValue: initialValue,
      dropdownIconPosition: IconPosition.trailing,
      initialCountryCode: countryCode,
      flagsButtonPadding: EdgeInsets.all(flagsPadding),
      readOnly: readOnly,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
        fontFamily: 'OpenSans',
      ),
      decoration: InputDecoration(
        filled: true,
        counterText: '',
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
      languageCode: "en",
      onChanged: onChanged,
      onSaved: onSaved,
      onCountryChanged: onCountryChanged,
      onSubmitted: onSubmitted,
    );
  }
}
