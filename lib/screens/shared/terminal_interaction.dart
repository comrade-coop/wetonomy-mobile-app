import 'package:flutter/material.dart';

class TerminalInteraction {
  Color snackBarColor;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  void showSnackBar(String message, Color snackBarColor) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: snackBarColor,
        content: new Text(message)));
  }
}