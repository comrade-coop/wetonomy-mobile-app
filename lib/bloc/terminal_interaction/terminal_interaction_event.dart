import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/models.dart';

@immutable
abstract class TerminalInteractionEvent extends Equatable {
  TerminalInteractionEvent([List props = const <dynamic>[]]) : super(props);
}

class ReceiveActionFromTerminalEvent extends TerminalInteractionEvent {
  final Action action;

  ReceiveActionFromTerminalEvent(String serialisedAction)
      : action = Action.fromJsonString(serialisedAction),
        super([serialisedAction]);
}

class ReceiveQueryFromTerminalEvent extends TerminalInteractionEvent {
  final Query query;

  ReceiveQueryFromTerminalEvent(String serialisedQuery)
      : query = Query.fromJsonString(serialisedQuery),
        super([serialisedQuery]);
}

class ContractChangedEvent extends TerminalInteractionEvent {
  final Contract contract;

  ContractChangedEvent(this.contract) : super([contract]);
}
