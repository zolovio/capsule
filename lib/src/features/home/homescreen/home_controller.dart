import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dashboard/dashboard.dart';
import '../exam_history/exam_screen.dart';
import '../library/library_screen.dart';
import '../profile/profile_screen.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;

  final List<Widget> pages = [
    Dashboard(),
    LibraryScreen(),
    ExamsScreen(),
    ProfileScreen(),
  ];

  void onIndexTapped(int index) {
    currentIndex.value = index;
  }

  handleBackNavigation() {
    Get.back();
  }
}
