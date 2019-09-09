import 'package:flutter/material.dart';
import 'package:wetonomy/components/account_avatar.dart';
import 'package:wetonomy/models/models.dart';
import 'package:wetonomy/screens/terminal/components/terminal_search.dart';

Widget buildTerminalAppBar({TerminalData terminal}) {
  return AppBar(
    title: Text(
      terminal != null ? terminal.name : '',
    ),
    actions: <Widget>[
      TerminalSearch(),
      AccountAvatar(),
    ],
  );
}
