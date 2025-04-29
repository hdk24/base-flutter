import 'dart:ui';

import 'package:flutter/scheduler.dart';

/// get default dark theme mode from device
bool get kIsDarkTheme =>
    SchedulerBinding.instance.platformDispatcher.platformBrightness ==
    Brightness.dark;

class AppConstant {
  /// default response count each page
  static const int DEFAULT_COUNT = 20;
}
