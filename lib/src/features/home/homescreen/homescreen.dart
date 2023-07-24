import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/palette.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.pinkGrade2,
          unselectedItemColor: AppColors.blueGrade2,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: controller.currentIndex.value,
          onTap: controller.onIndexTapped,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                ImgAssets.homeN,
                color: AppColors.blueGrade2,
              ),
              activeIcon: Image.asset(
                ImgAssets.homeN,
                color: AppColors.pinkGrade2,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                ImgAssets.bookN,
                color: AppColors.blueGrade2,
              ),
              activeIcon: Image.asset(
                ImgAssets.bookN,
                color: AppColors.pinkGrade2,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                ImgAssets.listN,
                color: AppColors.blueGrade2,
              ),
              activeIcon: Image.asset(
                ImgAssets.listN,
                color: AppColors.pinkGrade2,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                ImgAssets.userN,
                color: AppColors.blueGrade2,
              ),
              activeIcon: Image.asset(
                ImgAssets.userN,
                color: AppColors.pinkGrade2,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
