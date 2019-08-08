import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/models.dart';

@immutable
abstract class TerminalState extends Equatable {
  TerminalState([List props = const <dynamic>[]]) : super(props);
}

class InitialTerminalState extends TerminalState {}

class LoadingTerminalState extends TerminalState {}

class LoadedTerminalState extends TerminalState {
  final List<TerminalData> terminals;

  LoadedTerminalState(this.terminals) : assert(terminals != null);
}
