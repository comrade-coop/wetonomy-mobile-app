import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/terminal_data.dart';

@immutable
abstract class TerminalEvent extends Equatable {
  TerminalEvent([List props = const <dynamic>[]]) : super(props);
}

class AddTerminalEvent extends TerminalEvent {
  final TerminalData terminal;

  AddTerminalEvent(this.terminal)
      : assert(terminal != null),
        super([terminal]);
}

class RemoveTerminalEvent extends TerminalEvent {
  final TerminalData terminal;

  RemoveTerminalEvent(this.terminal)
      : assert(terminal != null),
        super([terminal]);
}
