import 'package:flutter/material.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/screens/terminal/components/terminals_list.dart';

class TerminalsSection extends StatelessWidget {
  final List<TerminalData> terminals;
  final Function(int) onTerminalSelected;
  final int selectedTerminalIndex;

  const TerminalsSection(
      {Key key,
      @required this.terminals,
      @required this.onTerminalSelected,
      this.selectedTerminalIndex})
      : super(key: key);

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
          _buildTerminalsListOrEmptyView(),
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

  Widget _buildTerminalsListOrEmptyView() {
    if (this.terminals.length == 0) {
      return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('You don\'t have any terminals installed currently.'),
          ));
    }

    return Expanded(
        child: TerminalsList(
            terminals: this.terminals,
            onTerminalSelected: onTerminalSelected,
            selectedTerminalIndex: selectedTerminalIndex));
  }
}
