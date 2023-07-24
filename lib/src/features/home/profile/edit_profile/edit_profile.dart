// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../components/custom_appbar.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_date_picker.dart';
import '../../../../components/custom_divider.dart';
import '../../../../components/custom_dropdown.dart';
import '../../../../components/custom_percent_indicator.dart';
import '../../../../components/custom_phone_input.dart';
import '../../../../components/custom_shaded_text.dart';
import '../../../../components/custom_textfield.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/font_weight.dart';
import '../../../../core/constants/palette.dart';
import '../../../../core/constants/strings.dart';
import 'edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        appBar: AppBar(),
        text: strMyAccount,
        fontWeight: fontWeight600,
        fontSize: font_20,
        textColor: AppColors.pinkGrade2,
        isEmptyTitle: false,
        isLeading: true,
        isCenter: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_35),
        children: [
          Center(
            child: Stack(
              children: [
                CustomPercentIndicator(
                  radius: radius_60,
                  lineWidth: width_5,
                  percent: 0.8,
                  reverse: true,
                  startAngle: 70,
                  animation: false,
                  animationDuration: 1000,
                  animateFromLastPercent: false,
                  progressColor: AppColors.pinkGrade2,
                  backgroundColor: AppColors.pinkGrade2.withOpacity(0.2),
                  image: ImgAssets.userProf1,
                  isProfile: true,
                ),
                Positioned(
                  left: margin_80,
                  top: margin_75,
                  child: IconButton(
                    onPressed: () {},
                    icon: const CircleAvatar(
                      backgroundColor: AppColors.pinkGrade2,
                      child: Icon(
                        Icons.edit,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomDivider(height: height_10, isDivider: false),
          CustomShadedText(
            text: "Hello, Danish",
            fontWeight: fontWeight600,
            fontSize: font_18,
            textColor: AppColors.pinkGrade2,
            textAlignment: TextAlign.center,
          ),
          CustomDivider(height: height_15, isDivider: false),
          Column(
            children: [
              FormBuilder(
                key: controller.formKey,
                onChanged: () => controller.formKey.currentState!.save(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: margin_0),
                  child: Column(
                    children: [
                      CustomDivider(height: height_10, isDivider: false),
                      CustomTextField(
                        name: 'first_name',
                        initialValue: controller.profileController.profileDetail.value.firstName!,
                        labelText: "First Name",
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
                        name: 'last_name',
                        initialValue: controller.profileController.profileDetail.value.lastName!,
                        labelText: "Last Name",
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
                      CustomPhoneInput(
                        name: 'phone',
                        countryCode: 'IN',
                        controller: controller.phoneController,
                        labelText: "Phone number",
                        labelColor: AppColors.pinkGrade2,
                        fontSize: font_12,
                        fontWeight: fontWeight400,
                        radius: radius_10,
                        fillColor: AppColors.pinkFillColor,
                        borderColor: AppColors.pinkGrade2,
                        borderWidth: width_1,
                        flagsPadding: margin_10,
                      ),
                      CustomDivider(height: height_20, isDivider: false),
                      CustomDropdown(
                        name: 'gender',
                        initialValue: controller.profileController.profileDetail.value.gender!,
                        labelText: "Gender",
                        labelColor: AppColors.pinkGrade2,
                        fontSize: font_12,
                        fontWeight: fontWeight400,
                        radius: radius_10,
                        inputType: TextInputType.none,
                        fillColor: AppColors.pinkFillColor,
                        borderColor: AppColors.pinkGrade2,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.pinkGrade2,
                        ),
                        options: controller.genderOptions,
                        onChanged: (String value) {},
                        formBuilderValidators: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                      ),
                      CustomDivider(height: height_20, isDivider: false),
                      CustomTextField(
                        name: 'email_address',
                        initialValue: controller.profileController.profileDetail.value.email,
                        labelText: "Email Address",
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
                        name: 'class',
                        initialValue: controller.profileController.profileDetail.value.classes,
                        labelText: "Which class are you in?",
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
                        name: 'school',
                        initialValue: controller.profileController.profileDetail.value.classes,
                        labelText: "which school are you from?",
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
                        name: 'address',
                        initialValue: controller.profileController.profileDetail.value.country,
                        labelText: "Where are you From?",
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
                        initialValue:
                            DateTime.parse(controller.profileController.profileDetail.value.dob!),
                        labelText: "What is your birth date?",
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
                    ],
                  ),
                ),
              ),
              CustomDivider(height: height_25, isDivider: false),
              Obx(
                () => CustomButton(
                  title: strUpdate,
                  fontWeight: fontWeight600,
                  fontSize: font_15,
                  horizontalPadding: margin_80,
                  minimumWidth: width_110,
                  minimumHeight: height_40,
                  radius: radius_40,
                  backgroundColor: AppColors.pinkGrade2,
                  textColor: AppColors.white,
                  borderColor: AppColors.pinkGrade2,
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.formKey.currentState?.saveAndValidate();

                    if (controller.formKey.currentState!.validate()) {
                      var formValues = controller.formKey.currentState!.value;

                      controller.handleUpdateProfile(
                        firstName: formValues["first_name"],
                        lastName: formValues["last_name"],
                        phone: controller.phoneController.text,
                        gender: formValues["gender"],
                        email: formValues["email_address"],
                        classes: formValues["class"],
                        school: formValues["school"],
                        address: formValues["address"],
                        dob: formValues["dob"].toString(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
