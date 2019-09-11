import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/models.dart';

@immutable
abstract class TerminalsManagerState extends Equatable {
  TerminalsManagerState([List props = const <dynamic>[]]) : super(props);
}

class InitialTerminalsManagerState extends TerminalsManagerState {}

class LoadingTerminalsManagerState extends TerminalsManagerState {}

class EmptyTerminalsManagerState extends TerminalsManagerState {}

class LoadedTerminalsManagerState extends TerminalsManagerState {
  final List<TerminalData> terminals;
  final TerminalData currentTerminal;

  LoadedTerminalsManagerState(this.terminals, this.currentTerminal)
      : assert(terminals != null),
        assert(terminals.length > 0 && terminals.contains(currentTerminal)),
        super([terminals, currentTerminal]);
}

class SelectedTerminalsManagerState extends LoadedTerminalsManagerState {
  SelectedTerminalsManagerState(
      List<TerminalData> terminals, TerminalData currentTerminal)
      : super(terminals, currentTerminal);
}

class AddedTerminalsManagerState extends LoadedTerminalsManagerState {
  AddedTerminalsManagerState(List<TerminalData> terminals, TerminalData currentTerminal)
      : super(terminals, currentTerminal);
}

class RemovedTerminalsManagerState extends LoadedTerminalsManagerState {
  RemovedTerminalsManagerState(
      List<TerminalData> terminals, TerminalData currentTerminal)
      : super(terminals, currentTerminal);
}
