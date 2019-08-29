import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/contracts/contracts_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_event.dart';
import 'package:wetonomy/repositories/contracts_repository.dart';
import 'package:wetonomy/repositories/terminals_repository.dart';
import 'package:wetonomy/services/service_locator.dart';

import 'logging_bloc_delegate.dart';

List<BlocProvider> createBlocProviders() {
  if (kDebugMode) {
    BlocSupervisor.delegate = LoggingBlocDelegate();
  }

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
