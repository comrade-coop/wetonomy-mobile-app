import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/repositories/repositories.dart';
import './bloc.dart';

class TerminalsBloc extends Bloc<TerminalsEvent, TerminalsState> {
  final StrongForceRepository _repository;

  TerminalsBloc(this._repository) : assert(_repository != null);

  @override
  TerminalsState get initialState => InitialTerminalState();

  @override
  Stream<TerminalsState> mapEventToState(
    TerminalsEvent event,
  ) async* {
    if (event is AddTerminalEvent) {
      yield LoadingTerminalState();
      yield await _handleAddTerminalEvent(event);
    }

    if (event is RemoveTerminalEvent) {
      yield LoadingTerminalState();
      yield await _handleRemoveTerminalEvent(event);
    }

    if (event is LoadTerminalsEvent) {
      yield LoadingTerminalState();
      yield await _handleLoadTerminalsEvent();
    }

    if (event is SelectTerminalEvent) {
      yield LoadingTerminalState();
      yield await _handleSelectTerminalEvent(event);
    }
  }

  Future<TerminalsState> _handleAddTerminalEvent(AddTerminalEvent event) async {
    await _repository.addTerminal(event.terminal);
    List<TerminalData> terminals = await _repository.getAllTerminals();
    return LoadedTerminalState(terminals);
  }

  Future<TerminalsState> _handleRemoveTerminalEvent(
      RemoveTerminalEvent event) async {
    await _repository.removeTerminal(event.terminal);
    List<TerminalData> terminals = await _repository.getAllTerminals();
    return LoadedTerminalState(terminals);
  }

  Future<TerminalsState> _handleSelectTerminalEvent(
      SelectTerminalEvent event) async {
    TerminalsState state = currentState;
    if (state is LoadedTerminalState) {
      List<TerminalData> terminals = state.terminals;
      int index = event.terminalIndex;

      if (index < 0 || index >= terminals.length) {
        return state;
      }

      return LoadedTerminalState(terminals,
          selectedTerminalIndex: event.terminalIndex);
    }
    return state;
  }

  Future<TerminalsState> _handleLoadTerminalsEvent() async {
    List<TerminalData> terminals = await _repository.getAllTerminals();
    return LoadedTerminalState(terminals);
  }
}
