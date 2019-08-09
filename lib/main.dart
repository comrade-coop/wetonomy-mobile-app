import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/contracts_bloc.dart';
import 'package:wetonomy/bloc/logging_bloc_delegate.dart';
import 'package:wetonomy/repositories/strongforce_repository.dart';
import 'package:wetonomy/screens/terminal/terminal_screen.dart';
import 'package:wetonomy/services/service_locator.dart';

void main() async {
  BlocSupervisor.delegate = LoggingBlocDelegate();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContractsBloc>(
      builder: (context) => ContractsBloc(locator.get<StrongForceRepository>()),
      child: MaterialApp(
        title: 'Wetonomy',
        theme:
            ThemeData(brightness: Brightness.light, primaryColor: Colors.white),
        home: TerminalScreen(),
      ),
    );
  }
}
