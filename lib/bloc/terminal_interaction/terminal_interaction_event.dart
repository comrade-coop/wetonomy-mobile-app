import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/models.dart';

@immutable
abstract class TerminalInteractionEvent extends Equatable {
  TerminalInteractionEvent([List props = const <dynamic>[]]) : super(props);
}

class ReceiveActionFromTerminalEvent
    extends TerminalInteractionEvent {
  final String serialisedAction;

  ReceiveActionFromTerminalEvent(this.serialisedAction)
      : super([serialisedAction]);
}

class ReceiveQueryFromTerminalEvent extends TerminalInteractionEvent {
  final String serialisedQuery;

  ReceiveQueryFromTerminalEvent(this.serialisedQuery) : super([serialisedQuery]);
}

class SelectedTerminalInteractionEvent extends TerminalInteractionEvent {
  final TerminalData terminal;

  SelectedTerminalInteractionEvent(this.terminal) : super([terminal]);
}

class ContractStateUpdateEvent extends TerminalInteractionEvent {
  final Contract contract;

  ContractStateUpdateEvent(this.contract) : super([contract]);
}
