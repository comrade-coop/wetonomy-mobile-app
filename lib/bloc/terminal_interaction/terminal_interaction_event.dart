import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/models.dart';

@immutable
abstract class TerminalInteractionEvent extends Equatable {
  TerminalInteractionEvent([List props = const <dynamic>[]]) : super(props);
}

class ReceiveMessageTerminalInteractionEvent extends TerminalInteractionEvent {
  final String message;

  ReceiveMessageTerminalInteractionEvent(this.message) : super([message]);
}

class SelectedTerminalInteractionEvent extends TerminalInteractionEvent {
  final TerminalData terminal;

  SelectedTerminalInteractionEvent(this.terminal) : super([terminal]);
}
