import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/classes_model.dart';
import '../../../core/models/subjects_model.dart';
import '../../../core/repository/repository.dart';

class SubjectsController extends GetxController {
  RepositoryController repository = RepositoryController();

  RxList<ClassesModel> classes = <ClassesModel>[].obs;
  RxList<SubjectsModel> subjects = <SubjectsModel>[].obs;

  RxInt selectedIndex = 0.obs;
  RxInt classId = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadSubjects = false.obs;

  final List<Widget> pages = [const Text("data"), const Text("data1")];

  @override
  void onInit() {
    fetchClasses();

    super.onInit();
  }

  Future<void> fetchClasses() async {
    isLoading.toggle();

    List<ClassesModel>? classesModel = await repository.fetchClasses();

    if (classesModel != null) {
      classes.value = classesModel;
      classId.value = classesModel.first.id!;

      fetchClassSubjects(classId: classesModel.first.id!);
    }

    isLoading.toggle();
  }

  Future<void> fetchClassSubjects({required int classId}) async {
    isLoadSubjects.toggle();

    List<SubjectsModel>? subjectsModel = await repository.fetchClassSubjects(classId: classId);

    if (subjectsModel != null) {
      subjects.value = subjectsModel;
    }

    isLoadSubjects.toggle();
  }

  void onToggleSelected(int index, int classId) {
    selectedIndex.value = index;
    this.classId.value = classId;

    fetchClassSubjects(classId: classId);
  }

  handleBackNavigation() => Get.back();
}
