import 'package:flutter/material.dart';

ThemeData createDefaultTheme() {
  return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blueAccent,
      primaryColorDark: Colors.blue.shade700,
      primaryColorLight: Colors.blueAccent.shade100,
      accentColor: Colors.pink,
      backgroundColor: Colors.white);
}

ThemeData createPurpleTheme() {
  return ThemeData(
      brightness: Brightness.light,
      primaryColor: Color.fromRGBO(118, 56, 251, 1),
      primaryColorDark: Color.fromARGB(255, 131, 111, 254),
      primaryColorLight: Color.fromARGB(255, 131, 111, 254),
      accentColor: Color.fromRGBO(243, 144, 176, 1),
      backgroundColor: Color.fromRGBO(236, 236, 236, 1),
      );
} 
