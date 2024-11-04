import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightOutlinedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 1,
        shape: const RoundedRectangleBorder(),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        side: const BorderSide(color: Colors.white),
        padding: const EdgeInsets.symmetric(vertical: 10)),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 1,
        shape: const RoundedRectangleBorder(),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black),
        padding: const EdgeInsets.symmetric(vertical: 10)),
  );
}
