import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/models/models.dart';

@immutable
abstract class TerminalLoadState extends Equatable {
  TerminalLoadState([List props = const <dynamic>[]]) : super(props);
}

class LoadingTerminalState extends TerminalLoadState {
  final TerminalData terminal;

  LoadingTerminalState(this.terminal) : super([terminal]);
}

class LoadedTerminalState extends TerminalLoadState {
  final TerminalData terminal;

  LoadedTerminalState(this.terminal) : super([terminal]);
}

abstract class TerminalFacade {
  void receiveContractsState(ContractsState state);

  void selectTerminal(TerminalData terminal);

  Stream<TerminalLoadState> get onTerminalLoadStateChanged;
}
