import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/terminal_data.dart';

@immutable
abstract class TerminalsManagerEvent extends Equatable {
  TerminalsManagerEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadTerminalsEvent extends TerminalsManagerEvent {}

class SelectTerminalEvent extends TerminalsManagerEvent {
  final TerminalData terminal;

  SelectTerminalEvent(this.terminal)
      : assert(terminal != null),
        super([terminal]);
}

class AddTerminalEvent extends TerminalsManagerEvent {
  final TerminalData terminal;

  AddTerminalEvent(this.terminal)
      : assert(terminal != null),
        super([terminal]);
}

class RemoveTerminalEvent extends TerminalsManagerEvent {
  final TerminalData terminal;

  RemoveTerminalEvent(this.terminal)
      : assert(terminal != null),
        super([terminal]);
}

class SendTerminalActionEvent extends TerminalsManagerEvent {
  final ContractAction action;
  final TerminalData terminal;

  SendTerminalActionEvent(this.terminal, this.action) : super([action]);
}

class ReceiveMessageFromTerminalEvent extends TerminalsManagerEvent {
  final String message;

  ReceiveMessageFromTerminalEvent(this.message) : super([message]);
}
