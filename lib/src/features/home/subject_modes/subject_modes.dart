import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_card.dart';
import '../../../components/custom_text.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import 'subject_mode_controller.dart';

class SubjectModeScreen extends StatefulWidget {
  const SubjectModeScreen({Key? key}) : super(key: key);

  @override
  State<SubjectModeScreen> createState() => _SubjectModeScreenState();
}

class _SubjectModeScreenState extends State<SubjectModeScreen> with TickerProviderStateMixin {
  SubjectModeController controller = Get.put(SubjectModeController());

  late TabController _nestedTabController;

  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Obx(
      () => ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_5),
            child: Center(
              child: TabBar(
                controller: _nestedTabController,
                isScrollable: true,
                physics: const NeverScrollableScrollPhysics(),
                unselectedLabelColor: AppColors.greyColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius_40),
                  color: AppColors.transparent,
                ),
                labelPadding: EdgeInsets.zero,
                onTap: controller.onSelectedIndex,
                tabs: controller.modes
                    .map<Widget>(
                      (mode) => Tab(
                        child: Container(
                          width: width_130,
                          margin: EdgeInsets.symmetric(horizontal: margin_5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius_40),
                            color: controller.selectedIndex.value == controller.modes.indexOf(mode)
                                ? AppColors.pinkGrade2
                                : AppColors.blueGrade2,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: CustomText(
                              text: mode,
                              fontWeight: fontWeight700,
                              fontSize: font_14,
                              textColor: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.7,
            child: TabBarView(
              controller: _nestedTabController,
              physics: const NeverScrollableScrollPhysics(),
              children: controller.modes
                  .map<Widget>(
                    (mode) => GridView.count(
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      children: controller.subjectsController.subjects
                          .map<Widget>(
                            (subject) => CustomCard(
                              cardColor: AppColors.pinkFillColor,
                              radius: radius_15,
                              padding: margin_15,
                              image: subject.subjectPicture!,
                              width: width_170,
                              text: subject.subjectName!,
                              fontWeight: fontWeight700,
                              fontSize: font_18,
                              textColor: AppColors.pinkGrade2,
                              height: height_70,
                              textAlign: TextAlign.center,
                              buttonBorderColor: AppColors.pinkGrade2,
                              onPressed: () => controller.onSubjectTapped(
                                mode: mode,
                                subjectsModel: subject,
                              ),
                              isVertical: true,
                            ),
                          )
                          .toList(),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
