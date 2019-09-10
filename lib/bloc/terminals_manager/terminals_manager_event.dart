import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/terminal_data.dart';

@immutable
abstract class TerminalsManagerEvent extends Equatable {
  TerminalsManagerEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadTerminalsManagerEvent extends TerminalsManagerEvent {}

class SelectTerminalsManagerEvent extends TerminalsManagerEvent {
  final TerminalData terminal;

  SelectTerminalsManagerEvent(this.terminal)
      : assert(terminal != null),
        super([terminal]);
}

class AddTerminalsManagerEvent extends TerminalsManagerEvent {
  final TerminalData terminal;

  AddTerminalsManagerEvent(this.terminal)
      : assert(terminal != null),
        super([terminal]);
}

class RemoveTerminalsManagerEvent extends TerminalsManagerEvent {
  final TerminalData terminal;

  RemoveTerminalsManagerEvent(this.terminal)
      : assert(terminal != null),
        super([terminal]);
}