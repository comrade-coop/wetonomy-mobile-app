import 'package:flutter/material.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/screens/terminal/components/icon_list_tile.dart';

class TerminalsList extends StatelessWidget {
  final List<TerminalData> terminals;
  final Function(TerminalData) onTerminalSelected;
  final int selectedTerminalIndex;

  const TerminalsList(
      {Key key,
      @required this.terminals,
      @required this.onTerminalSelected,
      this.selectedTerminalIndex = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
          padding: EdgeInsets.zero,
          children: _buildTerminalTiles(Theme.of(context).accentColor)),
    );
  }

  _buildTerminalTiles(Color selectedColor) => terminals
      .map((t) => TerminalListTile(
          title: t.url,
          icon: t.icon,
          selected: terminals.indexOf(t) == selectedTerminalIndex,
          color: Colors.black54,
          selectedColor: selectedColor,
          backgroundColor: Colors.transparent,
          selectedBackgroundColor: Colors.grey.withAlpha(30),
          onPressed: () => this.onTerminalSelected(t)))
      .toList();
}
