import 'package:flutter/material.dart';

import 'dao_search_section.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Row(
        children: <Widget>[
          DaoSearchSection(),
        ],
      ),
    );
  }
}
