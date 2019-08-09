import 'package:flutter/material.dart';
import 'package:wetonomy/screens/terminal/components/terminals_list.dart';

class TerminalsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text('Installed Terminals'),
          ),
          Expanded(child: TerminalsList()),
          _buildNewTerminalButton(Theme.of(context).primaryColorDark, () {})
        ],
      ),
    );
  }

  Widget _buildNewTerminalButton(Color iconColor, Function onPressed) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: OutlineButton.icon(
          onPressed: onPressed,
          label: Text('Add a new Terminal'),
          icon: Icon(Icons.add, color: iconColor),
        ),
      );
}
