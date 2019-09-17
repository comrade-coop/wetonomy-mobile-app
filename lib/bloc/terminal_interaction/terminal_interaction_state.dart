import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/models.dart';

@immutable
abstract class TerminalInteractionState extends Equatable {
  TerminalInteractionState([List props = const <dynamic>[]]) : super(props);
}

class InitialTerminalInteractionState extends TerminalInteractionState {}

class SelectedTerminalState extends TerminalInteractionState {
  final TerminalData terminal;

  SelectedTerminalState(this.terminal) : super([terminal]);
}

class ReceivedActionResultState extends TerminalInteractionState {
  final Map<String, dynamic> result;
  final Action action;

  ReceivedActionResultState(this.result, this.action) : super([result, action]);

  // TODO: Implement toEncodedJson
  String toEncodedJson() => '';
}

class ContractStateChangedState extends TerminalInteractionState {
  final Contract contract;

  ContractStateChangedState(this.contract) : super([contract]);
}
