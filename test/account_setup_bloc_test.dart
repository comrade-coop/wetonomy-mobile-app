import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_bloc.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_event.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_state.dart';
import 'package:wetonomy/repositories/account_repository.dart';

class AccountRepositoryMock extends Mock implements AccountRepository {}

void main() {
  group('AccountSetupBloc', () {
    test('Initial state is InitialAccountSetupState', () {
      final bloc = AccountSetupBloc(AccountRepositoryMock());
      expect(bloc.currentState, InitialAccountSetupState());
    });

    test('AddPasswordEvent goes to PasswordAddedState', () {
      final bloc = AccountSetupBloc(AccountRepositoryMock());
      final String password = 'test';

      expectLater(
          bloc.state,
          emitsInOrder([
            InitialAccountSetupState(),
            PasswordAddedState(password),
          ]));

      bloc.dispatch(AddPasswordEvent(password));
    });

    test('CreateMnemonicEvent creates a mnemonic after a password was added',
        () {
      final bloc = AccountSetupBloc(AccountRepositoryMock());
      final String password = 'test';

      expectLater(
          bloc.state,
          emitsInOrder([
            InitialAccountSetupState(),
            PasswordAddedState(password),
            (state) => state.runtimeType == MnemonicCreatedState
          ]));

      bloc.dispatch(AddPasswordEvent(password));
      bloc.dispatch(CreateMnemonicEvent());
    });

    test('SaveAccountEvent calls createAndPersistAccount', () {
      final repository = AccountRepositoryMock();

      bool calledPersistWallet = false;
      final String password = 'test';
      final String mnemonic = 'Mnemonic';
      when(repository.createMnemonic()).thenAnswer((_) => mnemonic);
      when(repository.createAndPersistWallet(mnemonic, password))
          .thenAnswer((_) {
        calledPersistWallet = true;
        return Future.value();
      });

      final bloc = AccountSetupBloc(repository);

      expectLater(
          bloc.state,
          emitsInOrder([
            InitialAccountSetupState(),
            PasswordAddedState(password),
            MnemonicCreatedState(mnemonic, password),
            SavingAccountState(),
            (AccountSavedState state) => calledPersistWallet == true,
          ]));

      bloc.dispatch(AddPasswordEvent(password));
      bloc.dispatch(CreateMnemonicEvent());
      bloc.dispatch(SaveAccountEvent());
    });
  });
}
