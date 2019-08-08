import 'package:flutter/material.dart';

// backing data
final europeanCountries = [
  'Albania',
  'Andorra',
  'Armenia',
  'Austria',
  'Azerbaijan',
  'Belarus',
  'Belgium',
  'Bosnia and Herzegovina',
  'Bulgaria'
];

class TerminalsSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TerminalsSectionState();
}

class _TerminalsSectionState extends State<TerminalsSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 200,
        child: ListView(
          children:
              europeanCountries.map((c) => ListTile(title: Text(c))).toList(),
        ),
      ),
    );
  }
}
