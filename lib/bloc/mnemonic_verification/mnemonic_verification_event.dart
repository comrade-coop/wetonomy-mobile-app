import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MnemonicVerificationEvent extends Equatable {
  MnemonicVerificationEvent([List props = const <dynamic>[]]) : super(props);
}

class SelectWordEvent extends MnemonicVerificationEvent {
  final int wordIndex;

  SelectWordEvent(this.wordIndex)
      : assert(wordIndex != null),
        super([wordIndex]);
}

class UnSelectWordEvent extends MnemonicVerificationEvent {
  final int wordIndex;

  UnSelectWordEvent(this.wordIndex)
      : assert(wordIndex != null),
        super([wordIndex]);
}

class ResetEvent extends MnemonicVerificationEvent {}

class VerifyMnemonicEvent extends MnemonicVerificationEvent {}
