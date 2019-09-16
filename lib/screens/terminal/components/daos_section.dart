import 'package:flutter/material.dart';
import 'package:wetonomy/screens/terminal/components/round_search_button.dart';

class DaosSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.black.withAlpha(10)),
        width: 64,
        child: SafeArea(
          top: true,
          left: false,
          right: false,
          bottom: false,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: RoundSearchButton(onPressed: _handleAddNewDao),
              )
            ],
          ),
        ));
  }

  void _handleAddNewDao() {}
}
