import 'package:flutter_test/flutter_test.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/mnemonic_verification/word_field.dart';

import 'wallet_test_data.dart';

void main() {
  final mnemonic = WalletTestData.mnemonic.split(' ');

  group('MnemonicVerificationBloc', () {
    test('Initial state has an empty selected words list and full remaining',
        () {
      final bloc = MnemonicVerificationBloc(mnemonic);
      expect(bloc.currentState.selectedWords, []);
      mnemonic.forEach((String m) => expect(
          bloc.currentState.remainingWords.contains(WordField(m, false)),
          true));
    });
  });

  test('Adding a word removes it from remaining and adds it to selected', () {
    final bloc = MnemonicVerificationBloc(mnemonic);
    final List<WordField> remainingWords = []
      ..addAll(bloc.currentState.remainingWords);
    final String wordToRemove = remainingWords[3].word;

    expectLater(
        bloc.state,
        emitsInOrder([
          (state) => state.runtimeType == MnemonicVerificationState,
          // Initial
          (MnemonicVerificationState state) {
            expect(state.remainingWords[3].selected, true);
            expect(state.selectedWords, [WordField(wordToRemove, false)]);
            return true;
          }
        ]));

    bloc.dispatch(SelectWordEvent(3));
  });

  test('Removing a word from selected returns it to remaining', () {
    final bloc = MnemonicVerificationBloc(mnemonic);
    final List<WordField> remainingWords = []
      ..addAll(bloc.currentState.remainingWords);

    expectLater(
        bloc.state,
        emitsInOrder([
          (state) => state.runtimeType == MnemonicVerificationState,
          // Initial
          (state) => state.runtimeType == MnemonicVerificationState,
          // Select at 0
          (state) => state.runtimeType == MnemonicVerificationState,
          // Select at 3
          (MnemonicVerificationState state) {
            expect(state.remainingWords[0], remainingWords[0]);
            expect(state.selectedWords,
                [WordField(remainingWords[0].word, true), remainingWords[3]]);
            return true;
          },
          (MnemonicVerificationState state) {
            expect(state.remainingWords[0], remainingWords[0]);
            expect(state.selectedWords, []);
            return true;
          }
        ]));

    bloc.dispatch(SelectWordEvent(0));
    bloc.dispatch(SelectWordEvent(3));
    bloc.dispatch(UnSelectWordEvent(0));
    bloc.dispatch(UnSelectWordEvent(1));
  });

  test('Selecting mnemonic in correct order makes isValid property true', () {
    final bloc = MnemonicVerificationBloc(['1', '2', '3']);
    final List<WordField> remainingWords = bloc.currentState.remainingWords;

    expectLater(
        bloc.state,
        emitsInOrder([
          (MnemonicVerificationState state) {
            // Initial state
            expect(state.isValidSequence, false);
            return true;
          },
          (MnemonicVerificationState state) {
            // Select '1'
            expect(state.isValidSequence, false);
            return true;
          },
          (MnemonicVerificationState state) {
            // Select '2'
            expect(state.isValidSequence, false);
            return true;
          },
          (MnemonicVerificationState state) {
            // Select '3'
            expect(state.isValidSequence, true);
            return true;
          },
        ]));

    bloc.dispatch(
        SelectWordEvent(remainingWords.indexOf(WordField('1', false))));
    bloc.dispatch(
        SelectWordEvent(remainingWords.indexOf(WordField('2', false))));
    bloc.dispatch(
        SelectWordEvent(remainingWords.indexOf(WordField('3', false))));
  });
}
