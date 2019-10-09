import 'package:flutter/material.dart';

ThemeData createDefaultTheme() {
  return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      accentColor: Colors.blue,
      backgroundColor: Colors.white);
}

ThemeData createPurpleTheme() {
  return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      primaryColorDark: Color.fromARGB(255, 131, 111, 254),
      primaryColorLight: Color.fromARGB(255, 225, 153, 184),
      accentColor: Color.fromARGB(255, 131, 111, 254),
      backgroundColor: Colors.white);
}
