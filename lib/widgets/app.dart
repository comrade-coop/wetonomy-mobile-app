import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/contracts_bloc.dart';
import 'package:wetonomy/bloc/logging_bloc_delegate.dart';
import 'package:wetonomy/repositories/strongforce_repository.dart';
import 'package:wetonomy/services/service_locator.dart';
import 'package:wetonomy/widgets/main_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = LoggingBlocDelegate();
    StrongForceRepository repository = locator.get<StrongForceRepository>();

    return BlocProvider<ContractsBloc>(
      builder: (context) => ContractsBloc(repository),
      child: MaterialApp(
        title: 'Wetonomy',
        theme:
            ThemeData(brightness: Brightness.light, primaryColor: Colors.white),
        home: MainPage(),
      ),
    );
  }
}
