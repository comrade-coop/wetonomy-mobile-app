import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AccountSetupEvent extends Equatable {
  AccountSetupEvent([List props = const <dynamic>[]]) : super(props);
}

class AddPasswordEvent extends AccountSetupEvent {
  final String password;

  AddPasswordEvent(this.password)
      : assert(password != null),
        super([password]);
}

class RemovePasswordEvent extends AccountSetupEvent {}

class CreateMnemonicEvent extends AccountSetupEvent {}

class SaveAccountEvent extends AccountSetupEvent {}
