import 'package:flutter/material.dart';
import 'package:wetonomy/screens/terminal/components/add_dao_button.dart';

class DaosSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.black.withAlpha(10)),
        width: 64,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ListView(
            children: <Widget>[AddDaoButton(_onAddNewDao)],
          ),
        ));
  }

  void _onAddNewDao() {}
}
