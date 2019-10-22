import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';

@immutable
abstract class AccountsState extends Equatable {
  AccountsState([List props = const <dynamic>[]]) : super(props);
}

class InitialAccountsState extends AccountsState {}

class FetchingAccountsState extends AccountsState {}

class AccountsFetchedState extends AccountsState {
  final List<EncryptedWallet> accounts;

  AccountsFetchedState(this.accounts) : super([accounts]);
}
