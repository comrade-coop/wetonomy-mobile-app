import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';

@immutable
abstract class AccountsEvent extends Equatable {
  AccountsEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadAccountsEvent extends AccountsEvent {}

class UnlockAccountEvent extends AccountsEvent {
  final EncryptedWallet wallet;
  final String password;

  UnlockAccountEvent(this.wallet, this.password) : super([wallet, password]);
}
