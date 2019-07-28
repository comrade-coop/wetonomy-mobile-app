import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/repositories/strongforce_api_client_mock.dart';
import 'package:wetonomy/repositories/strongforce_repository.dart';
import 'package:wetonomy/widgets/app.dart';

import 'blocs/StrongForceBloc.dart';

class LoggingBlockDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  final StrongForceRepository repository =
      StrongForceRepository(StrongForceApiClientMock());
  BlocSupervisor.delegate = LoggingBlockDelegate();
  runApp(BlocProvider<StrongForceBloc>(
    builder: (context) => StrongForceBloc(repository),
    child: MyApp(),
  ));
}
