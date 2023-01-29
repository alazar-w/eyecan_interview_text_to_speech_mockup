import 'package:flutter/material.dart';

import 'app_localization.dart';

class LocalStrings {
  LocalStrings._();

  static String localString(
      {required String string, required BuildContext context}) {
    return AppLocalizations.of(context)?.translate(string) ??
        '$string not found';
  }
}
