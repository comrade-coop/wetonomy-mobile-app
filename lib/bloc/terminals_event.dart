import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/terminal_data.dart';

@immutable
abstract class TerminalsEvent extends Equatable {
  TerminalsEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadTerminalsEvent extends TerminalsEvent {}

class SelectTerminalEvent extends TerminalsEvent {
  final int terminalIndex;

  SelectTerminalEvent(this.terminalIndex)
      : assert(terminalIndex != null),
        super([terminalIndex]);
}

class AddTerminalEvent extends TerminalsEvent {
  final TerminalData terminal;

  AddTerminalEvent(this.terminal)
      : assert(terminal != null),
        super([terminal]);
}

class RemoveTerminalEvent extends TerminalsEvent {
  final TerminalData terminal;

  RemoveTerminalEvent(this.terminal)
      : assert(terminal != null),
        super([terminal]);
}
