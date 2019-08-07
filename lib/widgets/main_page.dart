import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/contracts_bloc.dart';
import 'package:wetonomy/widgets/drawer.dart';
import 'package:wetonomy/widgets/terminal.dart';

import '../dummy_terminals.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    ContractsBloc bloc = BlocProvider.of<ContractsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Terminal(dummyQueryTerminalUrl, bloc),
      drawer: AppDrawer(),
    );
  }
}