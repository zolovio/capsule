// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_text.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/font_weight.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/strings.dart';

class TermsScreen extends StatelessWidget {
  TermsScreen({Key? key}) : super(key: key);

  List<String> terms = [
    "Chapter wise and Topic wise question bank",
    "Questions are purely based on NCERT",
    "Answers provided with NCERT page number",
    "Mnemonics included",
    "Full length previous year papers",
    "Chapter wise and Topic wise question bank ",
    "Questions are purely based on NCERT ",
    "Answers provided with NCERT page number ",
    "Mnemonics included ",
    "Full length previous year papers ",
    "Chapter wise and Topic wise question bank  ",
    "Questions are purely based on NCERT  ",
    "Answers provided with NCERT page number  ",
    "Mnemonics included  ",
    " Full length previous year papers  ",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(
        appBar: AppBar(),
        text: strTermsNCondition,
        fontWeight: fontWeight600,
        fontSize: font_20,
        textColor: AppColors.pinkGrade2,
        isEmptyTitle: false,
        isLeading: true,
        isCenter: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_20),
        children: terms
            .map<Widget>(
              (e) => Row(
                children: [
                  CustomText(
                    text: "${terms.indexOf(e) + 1}.  ",
                    fontWeight: fontWeight500,
                    fontSize: font_14,
                    textColor: AppColors.black,
                    height: 2,
                  ),
                  CustomText(
                    text: e,
                    fontWeight: fontWeight500,
                    fontSize: font_14,
                    textColor: AppColors.black,
                    height: 2,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
