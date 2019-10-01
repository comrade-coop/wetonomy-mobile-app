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
  final String mnemonic;

  MnemonicCreatedState(this.mnemonic);
}

class AccountCreatedState extends AccountSetupState {
  final HDWallet wallet;

  AccountCreatedState(this.wallet);
}

class CreatingAccountState extends AccountSetupState {}
