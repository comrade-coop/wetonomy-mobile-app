import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/action_result.dart';
import 'package:wetonomy/models/models.dart';
import 'package:wetonomy/models/query_result.dart';

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
  final ActionResult result;

  ReceivedActionResultState(this.result) : super([result]);
}

class ContractStateChangedState extends TerminalInteractionState {
  final Contract contract;

  ContractStateChangedState(this.contract) : super([contract]);
}

class ReceivedQueryResultState extends TerminalInteractionState {
  final QueryResult result;

  ReceivedQueryResultState(this.result) : super([result]);
}
