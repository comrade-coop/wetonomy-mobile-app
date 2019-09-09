import 'package:flutter/material.dart';
import 'package:wetonomy/screens/add_new_terminal/add_new_terminal_screen.dart';
import 'package:wetonomy/screens/terminal/terminal_screen.dart';

Map<String, Widget Function(BuildContext)> createRoutes() {
  return {
    '/': (BuildContext context) => TerminalScreen(),
    '/add_new_terminal': (BuildContext context) => AddNewTerminalScreen(),
  };
}
