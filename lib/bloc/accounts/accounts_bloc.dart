import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/repositories/repositories.dart';
import 'package:wetonomy/services/mock_env.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';
import '../bloc.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final AccountRepository _repository;

  AccountsBloc(this._repository) : assert(_repository != null);

  @override
  AccountsState get initialState => InitialAccountsState();

  @override
  Stream<AccountsState> mapEventToState(
    AccountsEvent event,
  ) async* {
    if (event is LoadAccountsEvent) {
      yield FetchingAccountsState();
      yield await _handleFetchAccountEvent();
    } else if (event is UnlockAccountEvent) {
      yield ValidatingPasswordState();
      yield await _handleUnlockAccountEvent(event);
    }
  }

  Future<AccountsState> _handleFetchAccountEvent() async {
    final List<EncryptedWallet> accounts = await _repository.getAllWallets();

    if (accounts.isEmpty) {
      return EmptyAccountsState();
    }

    return AccountsLoadedState(accounts);
  }

  Future<AccountsState> _handleUnlockAccountEvent(
      UnlockAccountEvent event) async {
    try {
      final Wallet wallet =
          await _repository.tryUnlockWallet(event.wallet, event.password);
      return LoggedInState(wallet);
    } on ArgumentError {
      return WrongPasswordState();
    }
  }
}
