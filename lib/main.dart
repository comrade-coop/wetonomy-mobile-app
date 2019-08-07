import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/repositories/shared_preferences_terminal_manager.dart';
import 'package:wetonomy/repositories/strongforce_api_client_mock.dart';
import 'package:wetonomy/repositories/strongforce_repository.dart';
import 'package:wetonomy/widgets/app.dart';

import 'bloc/contracts_bloc.dart';
import 'logging_bloc_delegate.dart';

void main() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final apiClient = StrongForceApiClientMock();
  final terminalManager = SharedPreferencesTerminalManager(sharedPrefs);
  final repository = StrongForceRepository(apiClient, terminalManager);

  BlocSupervisor.delegate = LoggingBlocDelegate();

  runApp(BlocProvider<ContractsBloc>(
    builder: (context) => ContractsBloc(repository),
    child: MyApp(),
  ));
}
