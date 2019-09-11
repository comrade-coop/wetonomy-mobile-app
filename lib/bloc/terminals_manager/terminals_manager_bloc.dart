import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_event.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_state.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/repositories/repositories.dart';

class TerminalsManagerBloc
    extends Bloc<TerminalsManagerEvent, TerminalsManagerState> {
  final TerminalsRepository _terminalsRepository;

  TerminalsManagerBloc(this._terminalsRepository)
      : assert(_terminalsRepository != null);

  @override
  TerminalsManagerState get initialState => InitialTerminalsManagerState();

  @override
  Stream<TerminalsManagerState> mapEventToState(
    TerminalsManagerEvent event,
  ) async* {
    if (event is AddTerminalsManagerEvent) {
      yield await _handleAddTerminal(event.terminal);
    }

    if (event is RemoveTerminalsManagerEvent) {
      yield await _handleRemoveTerminal(event.terminal);
    }

    if (event is LoadTerminalsManagerEvent) {
      yield LoadingTerminalsManagerState();
      yield await _handleLoadTerminals();
    }

    if (event is SelectTerminalsManagerEvent) {
      yield await _handleSelectTerminal(event.terminal);
    }
  }

  Future<TerminalsManagerState> _handleAddTerminal(
      TerminalData terminal) async {
    bool wasAdded = await _terminalsRepository.addTerminal(terminal);
    if (wasAdded) {
      List<TerminalData> terminals =
          await _terminalsRepository.getAllTerminals();
      return AddedTerminalsManagerState(terminals, terminal);
    }

    return currentState;
  }

  Future<TerminalsManagerState> _handleRemoveTerminal(
      TerminalData terminal) async {
    if (!(currentState is LoadedTerminalsManagerState)) {
      throw Exception(
          'Can\'t remove a terminal if there are no loaded terminals.');
    }

    bool wasRemoved = await _terminalsRepository.removeTerminal(terminal);

    if (wasRemoved) {
      List<TerminalData> terminals =
          await _terminalsRepository.getAllTerminals();

      if (terminals.length == 0) {
        return EmptyTerminalsManagerState();
      }

      return RemovedTerminalsManagerState(terminals, terminals[0]);
    }

    return currentState;
  }

  Future<TerminalsManagerState> _handleSelectTerminal(
      TerminalData selected) async {
    TerminalsManagerState previousState = currentState;

    if (previousState is LoadedTerminalsManagerState) {
      List<TerminalData> terminals = previousState.terminals;

      return SelectedTerminalsManagerState(terminals, selected);
    } else {
      throw Exception('There are no terminals to select from.');
    }
  }

  Future<TerminalsManagerState> _handleLoadTerminals() async {
    List<TerminalData> terminals = await _terminalsRepository.getAllTerminals();

    if (terminals.length == 0) {
      return EmptyTerminalsManagerState();
    }

    return LoadedTerminalsManagerState(terminals, terminals[0]);
  }
}
