import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///[Navigator] related helped function with logic to generate code according to
///the active [Platform]
class Navigation {
  Navigation._();

  ///Get a [CupertinoPageRoute] for [Platform.isIOS] and
  ///[MaterialPageRoute] for [Platform.isAndroid]
  static Route getRoute(Widget widget) {
    if (kIsWeb) {
      return CupertinoPageRoute(builder: (BuildContext context) => widget);
    }
    return Platform.isIOS
        ? CupertinoPageRoute(builder: (BuildContext context) => widget)
        : MaterialPageRoute(builder: (BuildContext context) => widget);
  }
}
