import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/repositories/repositories.dart';
import './bloc.dart';

class TerminalBloc extends Bloc<TerminalEvent, TerminalState> {
  final StrongForceRepository _repository;

  TerminalBloc(this._repository) : assert(_repository != null);

  @override
  TerminalState get initialState => InitialTerminalState();

  @override
  Stream<TerminalState> mapEventToState(
    TerminalEvent event,
  ) async* {
    if (event is AddTerminalEvent) {
      yield LoadingTerminalState();
      yield await _handleAddTerminalEvent(event);
    }

    if (event is RemoveTerminalEvent) {
      yield LoadingTerminalState();
      yield await _handleRemoveTerminalEvent(event);
    }
  }

  Future<TerminalState> _handleAddTerminalEvent(AddTerminalEvent event) async {
    await _repository.addTerminal(event.terminal);
    List<TerminalData> terminals = await _repository.getAllTerminals();
    return LoadedTerminalState(terminals);
  }

  Future<TerminalState> _handleRemoveTerminalEvent(
      RemoveTerminalEvent event) async {
    await _repository.removeTerminal(event.terminal);
    List<TerminalData> terminals = await _repository.getAllTerminals();
    return LoadedTerminalState(terminals);
  }
}
