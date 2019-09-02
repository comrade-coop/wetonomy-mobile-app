import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/screens/terminal/components/terminal_drawer.dart';

class EmptyTerminalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StackDrawerScaffold(
      body: _buildBody(context),
      drawer: AppDrawer(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Looks like you don\'t have any terminals installed currently.\n\n Press the button below to add one.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        )),
        SizedBox(
          height: 16.0,
        ),
        FloatingActionButton(
          onPressed: () => _handleAddTerminalPressed(context),
          child: Icon(
            Icons.add,
            size: 32,
          ),
        )
      ],
    );
  }

  void _handleAddTerminalPressed(BuildContext context) {
    Navigator.pushNamed(context, 'add_new_terminal');
  }
}
