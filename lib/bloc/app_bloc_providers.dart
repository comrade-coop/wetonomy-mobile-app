import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_bloc.dart';
import 'package:wetonomy/repositories/repositories.dart';
import 'package:wetonomy/services/service_locator.dart';
import 'logging_bloc_delegate.dart';

List<BlocProvider> createBlocProviders() {
  if (kDebugMode) {
    BlocSupervisor.delegate = LoggingBlocDelegate();
  }

  final TerminalsRepository terminalsRepo = locator.get<TerminalsRepository>();
  final terminalsManagerBloc = TerminalsManagerBloc(terminalsRepo);
  final interactionBloc =
      TerminalInteractionBloc(terminalsRepo, terminalsManagerBloc);

  return [
    BlocProvider<TerminalsManagerBloc>(
      builder: (_) => terminalsManagerBloc,
    ),
    BlocProvider<TerminalInteractionBloc>(
      builder: (_) => interactionBloc,
    )
  ];
}
