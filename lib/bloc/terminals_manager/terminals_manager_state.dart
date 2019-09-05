import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/models.dart';

@immutable
abstract class TerminalsManagerState extends Equatable {
  TerminalsManagerState([List props = const <dynamic>[]]) : super(props);
}

class InitialTerminalsManagerState extends TerminalsManagerState {}

class LoadingTerminalsState extends TerminalsManagerState {}

class EmptyTerminalsManagerState extends TerminalsManagerState {}

class LoadedTerminalsState extends TerminalsManagerState {
  final List<TerminalData> terminals;
  final TerminalData currentTerminal;

  LoadedTerminalsState(this.terminals, this.currentTerminal)
      : assert(terminals != null),
        assert(terminals.length > 0 && terminals.contains(currentTerminal)),
        super([terminals, currentTerminal]);
}

class SelectedTerminalState extends LoadedTerminalsState {
  SelectedTerminalState(
      List<TerminalData> terminals, TerminalData currentTerminal)
      : super(terminals, currentTerminal);
}

class AddedTerminalState extends LoadedTerminalsState {
  AddedTerminalState(List<TerminalData> terminals, TerminalData currentTerminal)
      : super(terminals, currentTerminal);
}

class RemovedTerminalState extends LoadedTerminalsState {
  RemovedTerminalState(
      List<TerminalData> terminals, TerminalData currentTerminal)
      : super(terminals, currentTerminal);
}
