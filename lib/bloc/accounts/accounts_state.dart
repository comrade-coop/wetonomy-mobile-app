import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';

@immutable
abstract class AccountsState extends Equatable {
  AccountsState([List props = const <dynamic>[]]) : super(props);
}

class InitialAccountsState extends AccountsState {}

class FetchingAccountsState extends AccountsState {}

class EmptyAccountsState extends AccountsState {}

class AccountsFetchedState extends AccountsState {
  final List<EncryptedWallet> accounts;

  AccountsFetchedState(this.accounts) : super([accounts]);
}

class WrongPasswordState extends AccountsState {}

class ValidatingPasswordState extends AccountsState {}

class LoggedInState extends AccountsState {
  final Wallet wallet;

  LoggedInState(this.wallet) : super([wallet]);
}