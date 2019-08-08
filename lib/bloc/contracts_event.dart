import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/terminal_data.dart';

@immutable
abstract class ContractsEvent extends Equatable {
  ContractsEvent([List props = const []]) : super(props);
}

class SendActionEvent extends ContractsEvent {
  final TerminalData terminal;
  final ContractAction action;

  SendActionEvent(this.terminal, this.action) : super([action]);
}
