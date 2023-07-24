import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_date_picker.dart';
import '../../../components/custom_divider.dart';
import '../../../components/custom_dropdown.dart';
import '../../../components/custom_phone_input.dart';
import '../../../components/custom_textfield.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import 'profile_info_controller.dart';

class ProfileInfoScreen extends GetView<ProfileInfoController> {
  const ProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        appBar: AppBar(),
        text: strProfile,
        fontWeight: fontWeight600,
        fontSize: font_20,
        textColor: AppColors.pinkGrade2,
        isEmptyTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: margin_30),
        children: [
          Obx(
            () => FormBuilder(
              key: controller.formKey,
              onChanged: () {
                controller.formKey.currentState!.save();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: margin_20),
                child: Column(
                  children: [
                    CustomDivider(height: height_10, isDivider: false),
                    CustomTextField(
                      name: 'f_name',
                      labelText: strFirstName,
                      labelColor: AppColors.pinkGrade2,
                      fontSize: font_12,
                      fontWeight: fontWeight400,
                      radius: radius_10,
                      formBuilderValidators: [FormBuilderValidators.required()],
                      inputType: TextInputType.name,
                      fillColor: AppColors.pinkFillColor,
                      borderColor: AppColors.pinkGrade2,
                    ),
                    CustomDivider(height: height_20, isDivider: false),
                    CustomTextField(
                      name: 'l_name',
                      labelText: strLastName,
                      labelColor: AppColors.pinkGrade2,
                      fontSize: font_12,
                      fontWeight: fontWeight400,
                      radius: radius_10,
                      formBuilderValidators: [FormBuilderValidators.required()],
                      inputType: TextInputType.name,
                      fillColor: AppColors.pinkFillColor,
                      borderColor: AppColors.pinkGrade2,
                    ),
                    CustomDivider(height: height_20, isDivider: false),
                    CustomDatePicker(
                      name: 'dob',
                      labelText: strDateOfBirth,
                      labelColor: AppColors.pinkGrade2,
                      fontSize: font_12,
                      fontWeight: fontWeight400,
                      suffixIcon: Image.asset(ImgAssets.calenderIcon),
                      fillColor: AppColors.pinkFillColor,
                      borderWidth: width_1,
                      borderColor: AppColors.pinkGrade2,
                      radius: radius_10,
                      formBuilderValidators: [FormBuilderValidators.required()],
                    ),
                    CustomDivider(height: height_20, isDivider: false),
                    CustomTextField(
                      name: 'email',
                      labelText: strEmailAddress,
                      labelColor: AppColors.pinkGrade2,
                      fontSize: font_12,
                      fontWeight: fontWeight400,
                      radius: radius_10,
                      formBuilderValidators: [FormBuilderValidators.required()],
                      inputType: TextInputType.name,
                      fillColor: AppColors.pinkFillColor,
                      borderColor: AppColors.pinkGrade2,
                      suffixIcon: Image.asset(ImgAssets.messageIcon),
                      textInputType: TextInputType.emailAddress,
                    ),
                    CustomDivider(height: height_20, isDivider: false),
                    CustomTextField(
                      controller: controller.countryController,
                      name: 'country',
                      labelText: strCountry,
                      labelColor: AppColors.pinkGrade2,
                      fontSize: font_12,
                      fontWeight: fontWeight400,
                      radius: radius_10,
                      formBuilderValidators: [FormBuilderValidators.required()],
                      inputType: TextInputType.name,
                      fillColor: AppColors.pinkFillColor,
                      borderColor: AppColors.pinkGrade2,
                      suffixIcon: IconButton(
                        onPressed: () {
                          showCountryPicker(
                            context: context,
                            countryListTheme: CountryListThemeData(
                              flagSize: 25,
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                              bottomSheetHeight: 500,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              inputDecoration: InputDecoration(
                                labelText: 'Search',
                                hintText: 'Start typing to search',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(0xFF8C98A8).withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                            onSelect: (Country country) =>
                                controller.countryController.text = country.name,
                          );
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.pinkGrade2,
                        ),
                      ),
                    ),
                    CustomDivider(height: height_20, isDivider: false),
                    CustomPhoneInput(
                      name: 'phone',
                      controller: controller.authRepository.phoneController.value,
                      countryCode: controller.authRepository.countryCode.value,
                      labelText: "",
                      labelColor: AppColors.black,
                      fontSize: font_12,
                      fontWeight: fontWeight400,
                      radius: radius_10,
                      fillColor: AppColors.pinkFillColor,
                      borderColor: AppColors.pinkGrade2,
                      borderWidth: width_1,
                      flagsPadding: margin_10,
                      readOnly: false,
                    ),
                    CustomDivider(height: height_20, isDivider: false),
                    CustomDropdown(
                      name: 'gender',
                      labelText: strGender,
                      labelColor: AppColors.pinkGrade2,
                      fontSize: font_12,
                      fontWeight: fontWeight400,
                      radius: radius_10,
                      inputType: TextInputType.name,
                      fillColor: AppColors.pinkFillColor,
                      borderColor: AppColors.pinkGrade2,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.pinkGrade2,
                      ),
                      options: controller.genderOptions,
                      onChanged: (String value) {},
                      formBuilderValidators:
                          FormBuilderValidators.compose([FormBuilderValidators.required()]),
                    ),
                    CustomDivider(height: height_20, isDivider: false),
                    CustomDropdown(
                      name: 'class',
                      labelText: strClass,
                      labelColor: AppColors.pinkGrade2,
                      fontSize: font_12,
                      fontWeight: fontWeight400,
                      radius: radius_10,
                      inputType: TextInputType.name,
                      fillColor: AppColors.pinkFillColor,
                      borderColor: AppColors.pinkGrade2,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.pinkGrade2,
                      ),
                      options: controller.classOptions,
                      onChanged: (String value) {},
                      formBuilderValidators:
                          FormBuilderValidators.compose([FormBuilderValidators.required()]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomDivider(height: height_25, isDivider: false),
          CustomButton(
            title: strSubmit,
            fontWeight: fontWeight600,
            fontSize: font_15,
            horizontalPadding: margin_110,
            minimumWidth: width_90,
            minimumHeight: height_40,
            radius: radius_40,
            backgroundColor: AppColors.pinkGrade2,
            textColor: AppColors.white,
            borderColor: AppColors.pinkGrade2,
            isLoading: controller.isLoading.value,
            onPressed: () {
              if (controller.formKey.currentState!.validate()) {
                controller.onProfileCreation(
                  firstName: controller.formKey.currentState!.value["f_name"],
                  lastName: controller.formKey.currentState!.value["l_name"],
                  dob: DateFormat("d-MM-yyyy")
                      .format(controller.formKey.currentState!.value["dob"])
                      .toString()
                      .split(" ")[0],
                  email: controller.formKey.currentState!.value["email"],
                  phoneNumber: controller.authRepository.phoneCode.value +
                      controller.authRepository.phoneController.value.text,
                  gender: controller.formKey.currentState!.value["gender"],
                  className: controller.formKey.currentState!.value["class"],
                  country: controller.formKey.currentState!.value["country"],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
