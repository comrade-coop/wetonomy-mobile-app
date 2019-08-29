import 'package:flutter/material.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/screens/terminal/components/add_terminal_dialog.dart';
import 'package:wetonomy/components/terminals/terminals_list.dart';

class TerminalsListSection extends StatelessWidget {
  final List<TerminalData> terminals;
  final Function(TerminalData) onTerminalSelected;
  final int selectedTerminalIndex;

  const TerminalsListSection(
      {Key key,
      this.terminals,
      this.onTerminalSelected,
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
          _buildNewTerminalButton(
              iconColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AddTerminalDialog());
              })
        ],
      ),
    );
  }

  Widget _buildNewTerminalButton({Color iconColor, Function onPressed}) =>
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