import 'package:get/get.dart';

import '../../../components/custom_alert.dart';
import '../../../core/configs/routes.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/strings.dart';
import '../../../core/models/profile_model.dart';
import '../../../core/repository/repository.dart';
import 'edit_profile/edit_profile.dart';
import 'edit_profile/edit_profile_binding.dart';

class ProfileController extends GetxController {
  RepositoryController repository = RepositoryController();
  Rx<ProfileModel> profileDetail = ProfileModel().obs;

  RxBool isLoading = false.obs;

  List<Map<String, dynamic>> profile = [
    {
      "icon": ImgAssets.user,
      "title": strMyAccount,
      "subtitle": "Make changes to your account",
      "nav": "",
    },
    {
      "icon": ImgAssets.mcqHis,
      "title": strMcqHistory,
      "subtitle": "View Mcq History",
      "nav": AppRoutes.getMcqHistoryRoute(),
    },
    {
      "icon": ImgAssets.lib,
      "title": strLibrary,
      "subtitle": "View Library History",
      "nav": AppRoutes.getLibraryRoute(),
    },
    {
      "icon": ImgAssets.fon,
      "title": strContactUs,
      "subtitle": "Changes your Contact Number",
      "nav": AppRoutes.getContactRoute(),
    },
    {
      "icon": ImgAssets.terms,
      "title": strTermsNCondition,
      "subtitle": "Check our term and conditions",
      "nav": AppRoutes.getTermsRoute(),
    },
    {
      "icon": ImgAssets.like,
      "title": strRateUs,
      "subtitle": "Rate on play store",
      "nav": "",
    },
    {
      "icon": ImgAssets.logOut,
      "title": strLogout,
      "subtitle": "Further secure your account for safety",
      "nav": "",
    },
  ];

  @override
  void onInit() {
    fetchUserProfileDetails();

    super.onInit();
  }

  Future<void> fetchUserProfileDetails() async {
    isLoading.toggle();

    ProfileModel? profileModel = await repository.fetchUserProfileData(userId: 16);
    profileDetail.value = profileModel!;

    isLoading.toggle();
  }

  handleNavigation(String route) => Get.toNamed(route);

  showAlert() {
    Get.dialog(
      const CustomAlert(),
      barrierDismissible: false,
    );
  }

  setProfileEditing() => Get.to(() => EditProfileScreen(), binding: EditProfileBinding());
}
