import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AccountSetupState extends Equatable {
  AccountSetupState([List props = const <dynamic>[]]) : super(props);
}

class InitialAccountSetupState extends AccountSetupState {}

class PasswordAddedState extends AccountSetupState {
  final String password;

  PasswordAddedState(this.password) : super([password]);
}

class MnemonicCreatedState extends AccountSetupState {
  final String password;
  final String mnemonic;

  MnemonicCreatedState(this.mnemonic, this.password);
}

class AccountSavedState extends AccountSetupState {
  final HDWallet wallet;

  AccountSavedState(this.wallet);
}

class SavingAccountState extends AccountSetupState {}
