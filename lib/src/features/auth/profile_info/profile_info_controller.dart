import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../core/configs/routes.dart';
import '../../../core/models/success_model.dart';
import '../../../core/repository/auth_repository.dart';
import '../../../core/repository/repository.dart';

class ProfileInfoController extends GetxController {
  RepositoryController repositoryController = RepositoryController();
  AuthRepository authRepository = Get.find();

  final formKey = GlobalKey<FormBuilderState>();

  final TextEditingController countryController = TextEditingController();

  List<String> genderOptions = ["Male", "Female"];
  List<String> classOptions = ["XI", "XII"];

  RxBool isLoading = false.obs;

  Future<void> onProfileCreation({
    String? firstName,
    String? lastName,
    String? dob,
    String? email,
    String? phoneNumber,
    String? gender,
    String? className,
    String? country,
  }) async {
    isLoading.toggle();

    SuccessModel? success = await repositoryController.createUserProfile(
      jsonUserData: {
        "firstName": firstName,
        "lastName": lastName,
        "dob": dob,
        "email": email,
        "phoneNumber": phoneNumber,
        "gender": gender,
        "className": className,
        "country": country,
      },
    );

    if (success != null) {
      Get.offAndToNamed(AppRoutes.getHomeScreenRoute());
    }

    isLoading.toggle();
  }
}
