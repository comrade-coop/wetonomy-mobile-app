import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/contracts/contracts_bloc.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_bloc.dart';
import 'package:wetonomy/repositories/contracts_repository.dart';
import 'package:wetonomy/repositories/terminals_repository.dart';
import 'package:wetonomy/services/service_locator.dart';
import 'package:wetonomy/services/terminal_facade.dart';

import 'logging_bloc_delegate.dart';

List<BlocProvider> createBlocProviders() {
  if (kDebugMode) {
    BlocSupervisor.delegate = LoggingBlocDelegate();
  }

  final ContractsRepository contractsRepo = locator.get<ContractsRepository>();
  final TerminalsRepository terminalsRepo = locator.get<TerminalsRepository>();
  final TerminalFacade terminalFacade = locator.get<TerminalFacade>();
  final contractsBloc = ContractsBloc(contractsRepo);
  final terminalsManagerBloc = TerminalsManagerBloc(terminalsRepo);
  final interactionBloc = TerminalInteractionBloc(
      terminalFacade, terminalsManagerBloc, contractsBloc);

  return [
    BlocProvider<ContractsBloc>(
      builder: (_) => contractsBloc,
    ),
    BlocProvider<TerminalsManagerBloc>(
      builder: (_) => terminalsManagerBloc,
    ),
    BlocProvider<TerminalInteractionBloc>(
      builder: (_) => interactionBloc,
    )
  ];
}
