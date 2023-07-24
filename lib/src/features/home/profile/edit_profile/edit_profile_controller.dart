import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../core/models/profile_model.dart';
import '../../../../core/repository/repository.dart';
import '../profile_controller.dart';

class EditProfileController extends GetxController {
  RepositoryController repository = RepositoryController();
  ProfileController profileController = Get.find<ProfileController>();

  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController phoneController = TextEditingController();

  // String dateOfBirth = "";
  List<String> genderOptions = ["Male", "Female"];
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    phoneController.text = profileController.profileDetail.value.phoneNumber!;
    // List<String> dob = profileController.profileDetail.value.dob!.split("-").reversed.toList();
    //
    // dateOfBirth = "${dob[0]}-${dob[1]}-${dob[2]}";

    super.onInit();
  }

  Future<void> handleUpdateProfile({
    required String firstName,
    required String lastName,
    required String phone,
    required String gender,
    required String email,
    required String classes,
    required String school,
    required String address,
    required String dob,
  }) async {
    isLoading.toggle();

    bool updateProfile = await repository.updateUserProfileData(
      userId: 16,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      gender: gender,
      email: email,
      classes: classes,
      school: school,
      address: address,
      dob: dob.split(" ")[0],
    );

    if (updateProfile) {
      profileController.profileDetail.value = ProfileModel()
        ..id = 16
        ..userId = 0
        ..firstName = firstName
        ..lastName = lastName
        ..phoneNumber = phone
        ..gender = gender
        ..email = email
        ..classes = classes
        ..country = address
        ..dob = dob.split(" ")[0];
    }

    isLoading.toggle();
    Get.back();
  }
}
