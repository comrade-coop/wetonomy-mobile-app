import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/bloc/mnemonic_verification/word_field.dart';

@immutable
class MnemonicVerificationState extends Equatable {
  final List<WordField> selectedWords;
  final List<WordField> remainingWords;
  final bool isValidSequence;

  MnemonicVerificationState(
      this.remainingWords, this.selectedWords, this.isValidSequence)
      : super([remainingWords, selectedWords]);

  factory MnemonicVerificationState.initial(List<String> mnemonic) {
    final List<WordField> remainingWords = mnemonic
        .map((String word) => WordField(word, false))
        .toList()
          ..shuffle();

    return MnemonicVerificationState(remainingWords, [], false);
  }
}
