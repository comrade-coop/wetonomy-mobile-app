import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/models.dart';

@immutable
abstract class TerminalsState extends Equatable {
  TerminalsState([List props = const <dynamic>[]]) : super(props);
}

class InitialTerminalState extends TerminalsState {}

class LoadingTerminalState extends TerminalsState {}

class LoadedTerminalState extends TerminalsState {
  final List<TerminalData> terminals;
  final int selectedTerminalIndex;

  LoadedTerminalState(this.terminals, {this.selectedTerminalIndex = 0})
      : assert(terminals != null),
        assert(selectedTerminalIndex >= 0 &&
            (selectedTerminalIndex < terminals.length ||
                terminals.length == 0));
}
