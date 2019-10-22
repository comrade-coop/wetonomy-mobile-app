import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AccountsEvent extends Equatable {
  AccountsEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchAccountsEvent extends AccountsEvent {}