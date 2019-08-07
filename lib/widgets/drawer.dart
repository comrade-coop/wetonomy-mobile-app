import 'package:flutter/material.dart';
import 'package:wetonomy/widgets/dao_drawer_section.dart';

import 'dao_drawer_section.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Row(
        children: <Widget>[
          DaoDrawerSection(),
        ],
      ),
    );
  }
}
