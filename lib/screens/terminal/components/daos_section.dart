import 'package:flutter/material.dart';
import 'package:wetonomy/mock_resources.dart';
import 'package:wetonomy/screens/terminal/components/round_add_button.dart';

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
              _buildListItem(CircleAvatar(
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.network(
                    daoUrl,
                    width: 50,
                    height: 50,
                  ),
                ),
                radius: 30.0,
              )),
              _buildListItem(RoundSearchButton.RoundAddButton(onPressed: _handleAddNewDao))
            ],
          ),
        ));
  }

  Widget _buildListItem(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: child,
    );
  }

  void _handleAddNewDao() {}
}
