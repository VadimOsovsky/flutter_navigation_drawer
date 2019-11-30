import 'dart:async';

import 'package:flutter/material.dart';

class NavigationDrawerItem {
  final String title;
  final Widget icon;
  final Widget activeIcon;
  final Color selectedBackgroundColor;
  final bool enabled;
  final FutureOr<bool> Function(int) onPressed;

  int index;

  NavigationDrawerItem({
    @required this.title,
    this.icon,
    this.activeIcon,
    this.selectedBackgroundColor,
    this.enabled = true,
    this.onPressed,
  });
}
