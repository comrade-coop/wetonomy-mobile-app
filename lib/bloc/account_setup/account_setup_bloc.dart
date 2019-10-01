import 'dart:async';
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/repositories/account_repository.dart';

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
      final String mnemonic = _accountRepository.createMnemonic();
      yield MnemonicCreatedState(mnemonic);
    } else if (event is RemovePasswordEvent) {
      yield InitialAccountSetupState();
    } else if (event is CreateAccountEvent) {
      yield CreatingAccountState();
      yield await _handleCreateAccountEvent();
    }
  }

  Future<AccountSetupState> _handleCreateAccountEvent() async {
    final state = currentState;
    if (state is MnemonicCreatedState) {
      final HDWallet wallet =
          _accountRepository.createAndPersistAccount(state.mnemonic);
      return AccountCreatedState(wallet);
    }

    return state;
  }
}
