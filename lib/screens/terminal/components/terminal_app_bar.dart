import 'package:flutter/material.dart';
import 'package:wetonomy/components/account_avatar.dart';
import 'package:wetonomy/models/models.dart';
import 'package:wetonomy/screens/terminal/components/terminal_search.dart';

Widget buildTerminalAppBar(BuildContext context, {String title}) {
  return AppBar(
    title: Text(title ?? ''),
    actions: <Widget>[
      TerminalSearchButton(),
      AccountAvatar(),
    ],
    elevation: 0,
  );
}
