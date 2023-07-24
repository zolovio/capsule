import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_divider.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';
import '../subject_modes/subject_modes.dart';
import 'subjects_controller.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> with SingleTickerProviderStateMixin {
  SubjectsController controller = Get.find();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: controller.classes.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: controller.classes.length,
      child: Scaffold(
        appBar: CustomAppbar(
          appBar: AppBar(),
          text: strSubjects,
          fontWeight: fontWeight600,
          fontSize: font_20,
          textColor: AppColors.pinkGrade2,
          isEmptyTitle: false,
        ),
        body: ListView(
          children: <Widget>[
            Obx(
              () => controller.isLoading.isTrue
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: height_35,
                      margin: EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_10),
                      child: ListView.builder(
                        itemCount: controller.classes.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Obx(
                                () => CustomButton(
                                  title: controller.classes[index].className!,
                                  fontWeight: fontWeight700,
                                  fontSize: font_14,
                                  horizontalPadding: margin_0,
                                  minimumWidth: width_90,
                                  minimumHeight: height_40,
                                  radius: radius_40,
                                  backgroundColor: index == controller.selectedIndex.value
                                      ? AppColors.pinkGrade2
                                      : AppColors.blueGrade2,
                                  textColor: AppColors.white,
                                  borderColor: AppColors.transparent,
                                  onPressed: () => controller.onToggleSelected(
                                      index, controller.classes[index].id!),
                                ),
                              ),
                              CustomDivider(height: height_0, width: width_5, isDivider: false),
                            ],
                          );
                        },
                      ),
                    ),
            ),
            SizedBox(
              height: screenHeight * 0.78,
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: controller.classes
                    .map<Widget>(
                      (e) => Obx(
                        () => controller.isLoadSubjects.isTrue
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const SubjectModeScreen(),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
