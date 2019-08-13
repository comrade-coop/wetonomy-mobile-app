import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/repositories/contracts_repository.dart';
import './bloc.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  final ContractsRepository repository;

  ContractsBloc(this.repository) : assert(repository != null);

  @override
  ContractsState get initialState => ContractsState();

  @override
  Stream<ContractsState> mapEventToState(
    ContractsEvent event,
  ) async* {
    if (event is SendActionEvent) {
      yield await _handleSendActionEvent(event);
    }
  }

  Future<ContractsState> _handleSendActionEvent(SendActionEvent event) async {
    await repository.sendAction(event.action);
    Contract contract = await repository.getContractState(event.action.target);
    return ContractsState([contract]);
  }
}
