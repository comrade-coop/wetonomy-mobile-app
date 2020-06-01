import 'package:flutter/material.dart';
import 'package:wetonomy/screens/add_new_terminal/add_new_terminal_screen.dart';
import 'package:wetonomy/screens/splash/splash_screen.dart';
import 'package:wetonomy/screens/terminal/terminal_screen.dart';
import 'package:wetonomy/screens/welcome/welcome_screen.dart';
import 'package:wetonomy/screens/voting/voting_terminal.dart';
import 'package:wetonomy/screens/groups_members/groups_members_terminal.dart';

Map<String, Widget Function(BuildContext)> createRoutes() {
  return {
    '/': (_) => SplashScreen(),
    '/welcome': (_) => WelcomeScreen(),
    '/terminal': (_) => TerminalScreen(),
    '/add_new_terminal': (_) => AddNewTerminalScreen(),
    '/welcome': (_) => WelcomeScreen(),
  };
}

final Map<String, Widget> nativeTerminals = {
  "voting": VotingTerminal(),
  "groups": GroupsMembersTerminal()
};
