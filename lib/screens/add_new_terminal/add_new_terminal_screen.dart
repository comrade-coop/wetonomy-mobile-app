import 'package:flutter/material.dart';
import 'package:wetonomy/screens/add_new_terminal/components/add_new_terminal_section.dart';

class AddNewTerminalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Add a new Terminal'),
      ),
      body: AddNewTerminalSection(),
    );
  }
}
