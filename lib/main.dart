import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/contracts/contracts_bloc.dart';
import 'package:wetonomy/bloc/logging_bloc_delegate.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_event.dart';
import 'package:wetonomy/repositories/contracts_repository.dart';
import 'package:wetonomy/repositories/terminals_repository.dart';
import 'package:wetonomy/screens/add_new_terminal/add_new_terminal_screen.dart';
import 'package:wetonomy/screens/terminal/terminal_screen.dart';
import 'package:wetonomy/services/service_locator.dart';

void main() async {
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {
      BlocSupervisor.delegate = LoggingBlocDelegate();
    }

    return MultiBlocProvider(
      providers: _createBlocProviders(),
      child: MaterialApp(
        title: 'Wetonomy',
        theme: _createTheme(),
        initialRoute: '/',
        routes: _createRoutes(),
        navigatorObservers: [WebviewAutoHideNavigatorObserver()],
      ),
    );
  }

  ThemeData _createTheme() {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.blue,
        backgroundColor: Colors.white);
  }

  Map<String, Widget Function(BuildContext)> _createRoutes() {
    return {
      '/': (BuildContext context) => TerminalScreen(),
      '/add_new_terminal': (BuildContext context) => AddNewTerminalScreen(),
    };
  }

  List<BlocProvider> _createBlocProviders() {
    ContractsRepository contractsRepo = locator.get<ContractsRepository>();
    TerminalsRepository terminalsRepo = locator.get<TerminalsRepository>();

    return [
      BlocProvider<ContractsBloc>(
        builder: (context) => ContractsBloc(contractsRepo),
      ),
      BlocProvider<TerminalsManagerBloc>(
        builder: (context) =>
            TerminalsManagerBloc(terminalsRepo)..dispatch(LoadTerminalsEvent()),
      ),
    ];
  }
}
