import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/contracts/contracts_bloc.dart';
import 'package:wetonomy/bloc/logging_bloc_delegate.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_event.dart';
import 'package:wetonomy/repositories/contracts_repository.dart';
import 'package:wetonomy/repositories/terminals_repository.dart';
import 'package:wetonomy/screens/home/home_screen.dart';
import 'package:wetonomy/services/service_locator.dart';

import 'bloc/ui/ui_bloc.dart';

void main() async {
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContractsRepository contractsRepo = locator.get<ContractsRepository>();
    TerminalsRepository terminalsRepo = locator.get<TerminalsRepository>();

    if (!kReleaseMode) {
      BlocSupervisor.delegate = LoggingBlocDelegate();
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<ContractsBloc>(
          builder: (context) => ContractsBloc(contractsRepo),
        ),
        BlocProvider<TerminalsManagerBloc>(
          builder: (context) => TerminalsManagerBloc(terminalsRepo)
            ..dispatch(LoadTerminalsEvent()),
        ),
        BlocProvider<UiBloc>(
          builder: (context) => UiBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Wetonomy',
        theme:
            ThemeData(brightness: Brightness.light, primaryColor: Colors.white),
        home: HomeScreen(),
      ),
    );
  }
}
