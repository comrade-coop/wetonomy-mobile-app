import 'dart:async';
import 'package:bloc/bloc.dart';
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
    if (event is AddTerminalEvent) {
      yield await _handleAddTerminal(event.terminal);
    }

    if (event is RemoveTerminalEvent) {
      yield await _handleRemoveTerminal(event.terminal);
    }

    if (event is LoadTerminalsEvent) {
      yield LoadingTerminalsManagerState();
      yield await _handleLoadTerminals();
    }

    if (event is SelectTerminalEvent) {
      yield await _handleSelectTerminal(event.terminal);
    }
  }

  Future<TerminalsManagerState> _handleAddTerminal(
      TerminalData terminal) async {
    await _terminalsRepository.addTerminal(terminal);
    List<TerminalData> terminals = await _terminalsRepository.getAllTerminals();

    TerminalsManagerState previousState = this.currentState;
    if (previousState is LoadedTerminalsManagerState) {
      return SelectedTerminalsManagerState(
          terminals, previousState.currentTerminal);
    }

    return SelectedTerminalsManagerState(terminals, terminals[0]);
  }

  Future<TerminalsManagerState> _handleRemoveTerminal(
      TerminalData terminal) async {
    if (!(currentState is LoadedTerminalsManagerState)) {
      throw FormatException();
    }

    await _terminalsRepository.removeTerminal(terminal);
    List<TerminalData> terminals = await _terminalsRepository.getAllTerminals();

    if (terminals.length == 0) {
      return EmptyTerminalsManagerState();
    }

    if (terminals.contains(terminal)) {
      return SelectedTerminalsManagerState(terminals, terminal);
    }

    return SelectedTerminalsManagerState(terminals, terminals[0]);
  }

  Future<TerminalsManagerState> _handleSelectTerminal(
      TerminalData terminal) async {
    TerminalsManagerState previousState = currentState;

    if (previousState is LoadedTerminalsManagerState) {
      List<TerminalData> terminals = previousState.terminals;
      TerminalData selected = terminal;
      return SelectedTerminalsManagerState(terminals, selected);
    } else {
      throw FormatException();
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
