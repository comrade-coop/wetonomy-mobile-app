import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/contracts_bloc.dart';
import 'package:wetonomy/widgets/drawer.dart';
import 'package:wetonomy/widgets/terminal.dart';

import '../dummy_terminals.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    ContractsBloc bloc = BlocProvider.of<ContractsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Example Terminal'),
      ),
      body: Terminal(dummyQueryTerminalUrl, bloc),
      drawer: AppDrawer(),
    );
  }
}
