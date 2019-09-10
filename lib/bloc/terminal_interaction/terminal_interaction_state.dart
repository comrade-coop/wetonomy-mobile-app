import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TerminalInteractionState extends Equatable {
  TerminalInteractionState([List props = const <dynamic>[]]) : super(props);
}

class InitialTerminalInteractionState extends TerminalInteractionState {}
