import 'package:flutter/material.dart';
import 'package:wetonomy/screens/terminal/components/account_info_section.dart';
import 'package:wetonomy/screens/terminal/components/dao_info_section.dart';
import 'package:wetonomy/screens/terminal/components/daos_section.dart';
import 'package:wetonomy/screens/terminal/components/terminals_section_container.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DaosSection(),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DaoInfoSection(),
                      Divider(),
                      Expanded(child: TerminalsSectionContainer())
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          AccountInfoSection(),
        ],
      ),
    );
  }
}
