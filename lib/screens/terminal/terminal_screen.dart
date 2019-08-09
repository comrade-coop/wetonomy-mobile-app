import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/contracts_bloc.dart';
import 'package:wetonomy/services/dummy_terminals.dart';
import 'package:wetonomy/models/models.dart';
import 'package:wetonomy/screens/terminal/components/drawer.dart';
import 'package:wetonomy/screens/terminal/components/terminal.dart';

class TerminalScreen extends StatefulWidget {
  @override
  _TerminalScreenState createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  @override
  Widget build(BuildContext context) {
    ContractsBloc bloc = BlocProvider.of<ContractsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Example Terminal'),
        elevation: 1,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: null),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.withAlpha(50),
              child: Icon(
                Icons.person,
                size: 32,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
      body: Terminal(TerminalData(dummyQueryTerminalUrl, ['']), bloc),
      drawer: AppDrawer(),
    );
  }
}
