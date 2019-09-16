import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/models.dart';

@immutable
abstract class TerminalInteractionEvent extends Equatable {
  TerminalInteractionEvent([List props = const <dynamic>[]]) : super(props);
}

class ReceiveActionFromTerminalEvent extends TerminalInteractionEvent {
  final ContractAction action;

  ReceiveActionFromTerminalEvent(this.action) : super([action]);
}

class ReceiveQueryFromTerminalEvent extends TerminalInteractionEvent {
  final Query query;

  ReceiveQueryFromTerminalEvent(this.query) : super([query]);
}

class SelectedTerminalInteractionEvent extends TerminalInteractionEvent {
  final TerminalData terminal;

  SelectedTerminalInteractionEvent(this.terminal) : super([terminal]);
}

class ContractStateUpdateEvent extends TerminalInteractionEvent {
  final Contract contract;

  ContractStateUpdateEvent(this.contract) : super([contract]);
}
