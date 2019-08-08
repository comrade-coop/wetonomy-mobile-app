import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/repositories/strongforce_repository.dart';
import './bloc.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  final StrongForceRepository repository;

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
    List<Contract> contracts =
        await repository.getContractStateForTerminal(event.terminal);
    return ContractsState(contracts);
  }
}
