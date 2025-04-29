import 'package:base_flutter/src/presentation/resources/colors.dart';
import 'package:base_flutter/src/presentation/resources/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Reference:
// https://www.christianfindlay.com/blog/flutter-mastering-material-design3
// https://flutter.github.io/samples/web/material_3_demo/
class ThemeRes {
  /// light theme with colors from seed
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorRes.primary,
      brightness: Brightness.light,
    ),
    textTheme: TextRes.textTheme,
  );

  /// dark theme with colors from seed
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorRes.primary.shade200,
      brightness: Brightness.dark,
    ),
    textTheme: TextRes.textTheme,
  );

  /// change system navigation color based on theme mode
  static SystemUiOverlayStyle systemBarTheme(bool isDarkTheme) {
    if (isDarkTheme) {
      return SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: darkTheme.colorScheme.surfaceContainer,
      );
    } else {
      return SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: lightTheme.colorScheme.surfaceContainer,
      );
    }
  }
}
