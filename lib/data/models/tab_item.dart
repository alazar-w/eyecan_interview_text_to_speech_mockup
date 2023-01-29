import 'package:flutter/material.dart';

/// Model class that holds the tab info for the [PersistentBottomBarScaffold]
class PersistentTabItem {
  final String title;
  final IconData icon;

  PersistentTabItem({required this.title, required this.icon});
}