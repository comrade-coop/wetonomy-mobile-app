import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wetonomy/bloc/bloc.dart';

class TerminalInteraction {
  Color snackBarColor;
  
  TerminalInteractionBloc terminalInteractionBloc;
  StreamSubscription<TerminalInteractionState>
      terminalInteractionBlocSubscription;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  void showSnackBar(String message, Color snackBarColor) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: snackBarColor,
        content: new Text(message)));
  }
}