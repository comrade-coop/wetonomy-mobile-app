import 'package:flutter/material.dart';
import 'package:wetonomy/widgets/daos_section.dart';
import 'package:wetonomy/widgets/terminals_section.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Row(
        children: <Widget>[
          DaosSection(),
          TerminalsSection(),
        ],
      ),
    );
  }
}
