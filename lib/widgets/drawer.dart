import 'package:flutter/material.dart';
import 'package:wetonomy/widgets/AccountInfoSection.dart';
import 'package:wetonomy/widgets/DaoInfoSection.dart';
import 'package:wetonomy/widgets/daos_section.dart';
import 'package:wetonomy/widgets/terminals_section.dart';

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
                      Expanded(child: TerminalsSection())
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1,),
          AccountInfoSection(),
        ],
      ),
    );
  }
}
