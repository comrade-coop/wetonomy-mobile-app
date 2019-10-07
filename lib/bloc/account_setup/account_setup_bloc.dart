import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/repositories/account_repository.dart';
import 'package:wetonomy/wallet/wallet.dart';

import 'account_setup_event.dart';
import 'account_setup_state.dart';

class AccountSetupBloc extends Bloc<AccountSetupEvent, AccountSetupState> {
  final AccountRepository _accountRepository;

  AccountSetupBloc(this._accountRepository)
      : assert(_accountRepository != null);

  @override
  AccountSetupState get initialState => InitialAccountSetupState();

  @override
  Stream<AccountSetupState> mapEventToState(
    AccountSetupEvent event,
  ) async* {
    if (event is AddPasswordEvent) {
      yield PasswordAddedState(event.password);
    } else if (event is CreateMnemonicEvent) {
      yield _handleCreateMnemonicEvent();
    } else if (event is RemovePasswordEvent) {
      yield InitialAccountSetupState();
    } else if (event is SaveAccountEvent) {
      final state = currentState;
      if (state is MnemonicCreatedState) {
        yield SavingAccountState();
        yield await _handleSaveAccountEvent(state.mnemonic, state.password);
      } else {
        yield state;
      }
    }
  }

  Future<AccountSetupState> _handleSaveAccountEvent(
      String mnemonic, String password) async {
    final Wallet wallet =
        await _accountRepository.createAndPersistAccount(mnemonic, password);
    return AccountSavedState(wallet);
  }

  AccountSetupState _handleCreateMnemonicEvent() {
    final state = currentState;
    if (state is PasswordAddedState) {
      final String mnemonic = _accountRepository.createMnemonic();
      return MnemonicCreatedState(mnemonic, state.password);
    }

    return currentState;
  }
}
