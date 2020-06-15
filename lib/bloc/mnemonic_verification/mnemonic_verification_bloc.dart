import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/bloc/mnemonic_verification/word_field.dart';
import '../bloc.dart';

class MnemonicVerificationBloc
    extends Bloc<MnemonicVerificationEvent, MnemonicVerificationState> {
  final List<String> mnemonic;

  MnemonicVerificationBloc(this.mnemonic) : assert(mnemonic != null);

  @override
  MnemonicVerificationState get initialState =>
      MnemonicVerificationState.initial(mnemonic);

  @override
  Stream<MnemonicVerificationState> mapEventToState(
    MnemonicVerificationEvent event,
  ) async* {
    if (event is SelectWordEvent) {
      yield _handleSelectWordEvent(event);
    } else if (event is UnSelectWordEvent) {
      yield _handleUnSelectWordEvent(event);
    } else if (event is ResetEvent) {
      yield initialState;
    } else if (event is VerifyMnemonicEvent) {
      yield state;
    }
  }

  MnemonicVerificationState _handleSelectWordEvent(SelectWordEvent event) {
    final List<WordField> selectedWords = []
      ..addAll(state.selectedWords);
    final List<WordField> remainingWords = []
      ..addAll(state.remainingWords);
    final index = event.wordIndex;

    if (index < 0 || index >= remainingWords.length) {
      throw ArgumentError('SelectWord event wordIndex is invalid: $index');
    }

    if (remainingWords[index].selected) {
      throw ArgumentError(
          'SelectWord event word at index $index is already selected: $index');
    }

    _addToFirstSelected(selectedWords, remainingWords[index].word);
    remainingWords[index] = WordField(remainingWords[index].word, true);

    return MnemonicVerificationState(
        remainingWords, selectedWords, _isValidMnemonicSequence(selectedWords));
  }

  MnemonicVerificationState _handleUnSelectWordEvent(UnSelectWordEvent event) {
    final List<WordField> selectedWords = []
      ..addAll(state.selectedWords);
    final List<WordField> remainingWords = []
      ..addAll(state.remainingWords);
    final index = event.wordIndex;

    if (index < 0 || index >= selectedWords.length) {
      throw ArgumentError('UnSelectWord event wordIndex is invalid: $index');
    }

    if (selectedWords[index].selected) {
      return state;
    }

    _unSelect(remainingWords, selectedWords[index].word);
    if (index == selectedWords.length - 1) {
      selectedWords.removeLast();

      while (selectedWords.length > 0 && selectedWords.last.selected) {
        selectedWords.removeLast();
      }
    } else {
      selectedWords[index] = WordField(selectedWords[index].word, true);
    }

    return MnemonicVerificationState(remainingWords, selectedWords, false);
  }

  void _addToFirstSelected(List<WordField> words, String newWord) {
    int index = 0;
    while (index < words.length && !words[index].selected) {
      index++;
    }

    final wordField = WordField(newWord, false);
    if (index < words.length) {
      words[index] = wordField;
    } else {
      words.add(wordField);
    }
  }

  void _unSelect(List<WordField> words, String word) {
    int index = 0;
    while (index < words.length && words[index].word != word) {
      index++;
    }

    words[index] = WordField(word, false);
  }

  bool _isValidMnemonicSequence(List<WordField> selectedWords) {
    for (int i = 0; i < mnemonic.length; i++) {
      if (i >= selectedWords.length || mnemonic[i] != selectedWords[i].word) {
        return false;
      }
    }
    return true;
  }
}
