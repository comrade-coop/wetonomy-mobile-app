import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TerminalInteractionEvent extends Equatable {
  TerminalInteractionEvent([List props = const <dynamic>[]]) : super(props);
}

class ReceiveMessageFromTerminalEvent extends TerminalInteractionEvent {
  final String message;

  ReceiveMessageFromTerminalEvent(this.message) : super([message]);
}
