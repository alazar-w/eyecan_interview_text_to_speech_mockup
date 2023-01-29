import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;

class HiveDB {
  HiveDB._();

  static late final Box<String> _mockDB;
  static late final Box<bool> _oneOffs;
  static const String isLogin = 'isLogin';

  static Future initHive() async {
    if (!kIsWeb) {
      Directory appDocDir = await path.getApplicationDocumentsDirectory();
      await appDocDir.create(recursive: true);
      Hive.init(appDocDir.path);
    }
    _mockDB = await Hive.openBox<String>('mockDB');
    _oneOffs = await Hive.openBox<bool>('oneOffs');
  }

  static void addAccessToken(String token) {
    _mockDB.put("access_token", token);
  }

  static String? getAccessToken() {
    return _mockDB.get("access_token");
  }

  // add data
  static void addisLoggedIn(bool value) {
    _oneOffs.put(isLogin, value);
  }

  static void addAccessedApp(bool accessed) {
    _oneOffs.put("accessed_app", accessed);
  }

  static bool accessedApp() {
    return _oneOffs.get("accessed_app") ?? false;
  }
  // get data
  static bool isLoggedIn() {
    return _oneOffs.get(isLogin) ?? false;
  }

  static void addData(String key, String value) {
    _mockDB.put(key, value);
  }
  
  static String? getData(String key) {
    return _mockDB.get(key);
  }

  static logOut(){
    addisLoggedIn(false);
  }
}
