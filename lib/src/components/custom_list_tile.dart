import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../core/constants/dimensions.dart';
import 'custom_icon.dart';
import 'custom_text.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    this.elevation = 1,
    required this.margin,
    required this.tileColor,
    required this.radius,
    this.avatarColor,
    this.leadingText,
    this.leadingFontWeight,
    this.leadingFontSize,
    this.leadingTextColor,
    required this.titleText,
    required this.titleFontWeight,
    required this.titleFontSize,
    required this.titleTextColor,
    this.lineHeight,
    this.percent,
    this.indicatorColor,
    this.progressColor,
    this.trailingText,
    this.trailingFontWeight,
    this.trailingFontSize,
    this.trailingTextColor,
    this.isIndicator = true,
    this.subtitleText,
    this.subtitleFontWeight,
    this.subtitleFontSize,
    this.subtitleTextColor,
    this.subtitleList,
    this.isSubtitleList = false,
    this.isListOnly = false,
    required this.onTap,
    this.image,
    this.imageColor,
    this.containerColor,
    this.icon,
    this.iconColor,
    this.containerPadding,
  }) : super(key: key);

  final double elevation;
  final double margin;
  final Color tileColor;
  final double radius;
  final Color? avatarColor;
  final String? leadingText;
  final FontWeight? leadingFontWeight;
  final double? leadingFontSize;
  final Color? leadingTextColor;
  final String titleText;
  final FontWeight titleFontWeight;
  final double titleFontSize;
  final Color titleTextColor;
  final String? subtitleText;
  final FontWeight? subtitleFontWeight;
  final double? subtitleFontSize;
  final Color? subtitleTextColor;
  final double? lineHeight;
  final double? percent;
  final Color? indicatorColor;
  final Color? progressColor;
  final String? trailingText;
  final FontWeight? trailingFontWeight;
  final double? trailingFontSize;
  final Color? trailingTextColor;
  final Map<String, dynamic>? subtitleList;
  final bool isIndicator;
  final bool isSubtitleList;
  final String? image;
  final Color? imageColor;
  final Color? containerColor;
  final double? containerPadding;
  final IconData? icon;
  final Color? iconColor;
  final Function onTap;
  final bool isListOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: margin),
      child: Card(
        elevation: elevation,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: ListTile(
          onTap: () => onTap(),
          selected: true,
          selectedTileColor: tileColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          leading: isListOnly
              ? CustomIcon(
                  image: image!,
                  imageColor: imageColor!,
                  containerColor: containerColor!,
                  margin: containerPadding!,
                  onPressed: null,
                )
              : CircleAvatar(
                  backgroundColor: avatarColor,
                  child: CustomText(
                    text: leadingText!,
                    fontWeight: leadingFontWeight!,
                    fontSize: leadingFontSize!,
                    textColor: leadingTextColor!,
                  ),
                ),
          title: CustomText(
            text: titleText,
            fontWeight: titleFontWeight,
            fontSize: titleFontSize,
            textColor: titleTextColor,
          ),
          subtitle: isIndicator
              ? LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  lineHeight: lineHeight!,
                  percent: percent!,
                  backgroundColor: indicatorColor,
                  barRadius: Radius.circular(radius_12),
                  progressColor: progressColor,
                )
              : isSubtitleList
                  ? CustomText(
                      text:
                          "Mcqs : ${subtitleList!["questionsCount"]} | Hours : ${subtitleList!["hours"]}"
                          " | Minutes : ${subtitleList!["minutes"]} | Seconds : ${subtitleList!["seconds"]}",
                      fontWeight: subtitleFontWeight!,
                      fontSize: subtitleFontSize!,
                      textColor: subtitleTextColor!,
                    )
                  : CustomText(
                      text: subtitleText!,
                      fontWeight: subtitleFontWeight!,
                      fontSize: subtitleFontSize!,
                      textColor: subtitleTextColor!,
                    ),
          trailing: isIndicator
              ? CustomText(
                  text: trailingText!,
                  fontWeight: trailingFontWeight!,
                  fontSize: trailingFontSize!,
                  textColor: trailingTextColor!,
                )
              : isListOnly
                  ? Icon(
                      icon!,
                      color: iconColor!,
                    )
                  : null,
        ),
      ),
    );
  }
}
