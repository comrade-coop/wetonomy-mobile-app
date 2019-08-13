import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/contract_action.dart';

@immutable
abstract class ContractsEvent extends Equatable {
  ContractsEvent([List props = const []]) : super(props);
}

class SendActionEvent extends ContractsEvent {
  final ContractAction action;

  SendActionEvent(this.action) : super([action]);
}
