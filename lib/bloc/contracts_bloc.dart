import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/models/result.dart';
import 'package:wetonomy/repositories/strongforce_repository.dart';
import './bloc.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  final StrongForceRepository repository;

  ContractsBloc(this.repository) : assert(repository != null);

  @override
  ContractsState get initialState => InitialContractsState();

  @override
  Stream<ContractsState> mapEventToState(
    ContractsEvent event,
  ) async* {
    if (event is SendActionEvent) {
      yield LoadingContractsState();
      Result result = await repository.sendAction(event.action);
      yield LoadedContractsState([]);
    }
  }
}
