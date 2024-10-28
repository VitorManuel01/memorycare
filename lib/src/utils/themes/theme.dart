import 'package:flutter/material.dart';
import 'package:memorycare/src/utils/themes/text_theme.dart';
import 'package:memorycare/src/utils/themes/widget_themes/elevated_button_theme.dart';
import 'package:memorycare/src/utils/themes/widget_themes/outlined_button_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    outlinedButtonTheme: TOutlineButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightOutlinedButtonTheme
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    outlinedButtonTheme: TOutlineButtonTheme.darkOutlineButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme
  );
}
