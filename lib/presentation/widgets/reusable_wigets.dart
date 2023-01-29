import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:interview_mockup/business/business.dart';
import 'package:sizer/sizer.dart';

class ReusableWidgets {
  ReusableWidgets._();

  static autoSizeText(
      ThemeStyle themeStyle, BuildContext context, String textKey) {
    return AutoSizeText(
      LocalStrings.localString(string: textKey, context: context),
      style: TextStyle(
        color: themeStyle.evenDarkColor,
        fontWeight: FontWeight.bold,
      ),
      maxFontSize: 15.sp.floorToDouble(),
      minFontSize: 10.sp.floorToDouble(),
    );
  }
}
