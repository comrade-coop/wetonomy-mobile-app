import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/repositories/repositories.dart';
import 'package:wetonomy/services/mock_env.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';
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
    switch (event.runtimeType) {
      case LoadAccountsEvent:
        yield FetchingAccountsState();
        yield await _handleFetchAccountEvent();
        break;
      default:
        yield currentState;
    }
  }

  Future<AccountsState> _handleFetchAccountEvent() async {
    final List<EncryptedWallet> accounts = await _repository.getAllWallets();

    if (accounts.isEmpty) {
      return EmptyAccountsState();
    }

    return AccountsFetchedState(accounts);
  }
}
