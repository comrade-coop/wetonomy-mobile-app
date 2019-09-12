import 'package:flutter/material.dart';

ThemeData createDefaultTheme() {
  return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      accentColor: Colors.blue,
      backgroundColor: Colors.white);
}

ThemeData createPinkTheme() {
  return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      primaryColorDark: Color.fromARGB(255, 180, 0, 78),
      primaryColorLight: Color.fromARGB(255, 255, 119, 169),
      accentColor: Colors.pink.shade400,
      backgroundColor: Colors.white);
}
