import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_textfield.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'contact_controller.dart';

class ContactScreen extends GetView<ContactController> {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        appBar: AppBar(),
        text: strContactUs,
        fontWeight: fontWeight600,
        fontSize: font_20,
        textColor: AppColors.pinkGrade2,
        isEmptyTitle: false,
        isLeading: true,
        isCenter: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: margin_20, vertical: margin_15),
        children: [
          FormBuilder(
            key: controller.formKey,
            child: Column(
              children: [
                CustomTextField(
                  name: 'name',
                  labelText: "Complete Name",
                  labelColor: AppColors.pinkGrade2,
                  fontSize: font_12,
                  fontWeight: fontWeight400,
                  formBuilderValidators: [
                    FormBuilderValidators.required(),
                  ],
                  inputType: TextInputType.name,
                  radius: radius_10,
                  fillColor: AppColors.pinkFillColor,
                  borderColor: AppColors.pinkGrade2,
                ),
                CustomDivider(height: height_15),
                CustomTextField(
                  name: 'phone',
                  labelText: "Phone Number",
                  labelColor: AppColors.pinkGrade2,
                  fontSize: font_12,
                  fontWeight: fontWeight400,
                  formBuilderValidators: [
                    FormBuilderValidators.required(),
                  ],
                  inputType: TextInputType.name,
                  radius: radius_10,
                  fillColor: AppColors.pinkFillColor,
                  borderColor: AppColors.pinkGrade2,
                ),
                CustomDivider(height: height_15),
                CustomTextField(
                  name: 'email',
                  labelText: "Email Address",
                  labelColor: AppColors.pinkGrade2,
                  fontSize: font_12,
                  fontWeight: fontWeight400,
                  formBuilderValidators: [
                    FormBuilderValidators.required(),
                  ],
                  inputType: TextInputType.name,
                  radius: radius_10,
                  fillColor: AppColors.pinkFillColor,
                  borderColor: AppColors.pinkGrade2,
                ),
                CustomDivider(height: height_15),
                CustomTextField(
                  name: 'message',
                  labelText: "Write Message here",
                  labelColor: AppColors.pinkGrade2,
                  fontSize: font_12,
                  fontWeight: fontWeight400,
                  formBuilderValidators: [
                    FormBuilderValidators.required(),
                  ],
                  inputType: TextInputType.name,
                  radius: radius_10,
                  fillColor: AppColors.pinkFillColor,
                  borderColor: AppColors.pinkGrade2,
                  maxLines: 8,
                  alignLabelWithHint: true,
                ),
              ],
            ),
          ),
          CustomDivider(height: height_30),
          CustomButton(
            title: strGetHelp,
            fontWeight: fontWeight600,
            fontSize: font_15,
            horizontalPadding: margin_80,
            minimumWidth: width_110,
            minimumHeight: height_40,
            radius: radius_40,
            backgroundColor: AppColors.pinkGrade2,
            textColor: AppColors.white,
            borderColor: AppColors.pinkGrade2,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
