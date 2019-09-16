import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/models.dart';

@immutable
abstract class TerminalInteractionState extends Equatable {
  TerminalInteractionState([List props = const <dynamic>[]]) : super(props);
}

class InitialTerminalInteractionState extends TerminalInteractionState {}

class ActiveTerminalInteractionState extends TerminalInteractionState {
  final TerminalData terminal;

  ActiveTerminalInteractionState(this.terminal) : super([terminal]);
}

class TerminalInteractionStateAfterAction extends TerminalInteractionState {
  final Map<String, dynamic> result;
  final Query query;
  TerminalInteractionStateAfterAction(this.result, this.query);

  String toEncodedJson() => "";
}

