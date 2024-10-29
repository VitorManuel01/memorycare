import 'package:flutter/material.dart';

class Ttextformfieldtheme {
  Ttextformfieldtheme._();

  static InputDecorationTheme lightInputDecorationTheme = 
  
  const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: Color(0xFF272727),
    floatingLabelStyle: TextStyle(color: Color(0xFF272727)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: Color(0xFF272727)),
    ));

      static InputDecorationTheme darkInputDecorationTheme = 
  
  const InputDecorationTheme(
    border: OutlineInputBorder(), 
    prefixIconColor: Colors.greenAccent,
    floatingLabelStyle: TextStyle(color: Colors.greenAccent),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: Colors.greenAccent),
    ));
}
