import 'package:flutter/material.dart';

//dummy data
final europeanCountries = [
  'Albania',
  'Azerbaijan',
  'Belarus',
  'Bosnia and Herzegovina',
  'Bulgaria'
];

class TerminalsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
          padding: EdgeInsets.zero,
          children: _buildTerminalTiles(Theme.of(context).accentColor)),
    );
  }

  _buildTerminalTiles(Color iconColor) => europeanCountries
      .map((c) => _buildTerminalTile(Icons.home, c, iconColor, c == 'Albania'))
      .toList();

  Widget _buildTerminalTile(
      IconData icon, String title, Color iconColor, bool selected) {
    if (selected) {
      return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.grey.withAlpha(30),
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: iconColor,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: TextStyle(color: iconColor),
              ),
            ],
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: Colors.black54,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
