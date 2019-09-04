import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_event.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_state.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/repositories/repositories.dart';

class TerminalsManagerBloc
    extends Bloc<TerminalsManagerEvent, TerminalsManagerState> {
  final TerminalsRepository _terminalsRepository;
  final ContractsBloc _contractsBloc;
  StreamSubscription<ContractsState> _contractsBlocSubscription;

  TerminalsManagerBloc(this._terminalsRepository, this._contractsBloc)
      : assert(_terminalsRepository != null),
        assert(_contractsBloc != null) {
    _contractsBlocSubscription =
        _contractsBloc.state.listen(_handleContractsStateChange);
  }

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

    if (event is ReceiveMessageFromTerminalEvent) {
      yield await _handleReceiveMessageFromTerminal(event);
    }
  }

  Future<TerminalsManagerState> _handleAddTerminal(
      TerminalData terminal) async {
    bool wasAdded = await _terminalsRepository.addTerminal(terminal);
    if (wasAdded) {
      List<TerminalData> terminals =
          await _terminalsRepository.getAllTerminals();
      _terminalsRepository.selectTerminal(terminal);
      return AddedTerminalState(terminals, terminal);
    }

    return currentState;
  }

  Future<TerminalsManagerState> _handleRemoveTerminal(
      TerminalData terminal) async {
    if (!(currentState is LoadedTerminalsState)) {
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

      _terminalsRepository.selectTerminal(terminals[0]);
      return RemovedTerminalState(terminals, terminals[0]);
    }

    return currentState;
  }

  Future<TerminalsManagerState> _handleSelectTerminal(
      TerminalData selected) async {
    TerminalsManagerState previousState = currentState;

    if (previousState is LoadedTerminalsState) {
      List<TerminalData> terminals = previousState.terminals;
      _terminalsRepository.selectTerminal(selected);

      return SelectedTerminalState(terminals, selected);
    } else {
      throw Exception('There are no terminals to select from.');
    }
  }

  Future<TerminalsManagerState> _handleLoadTerminals() async {
    List<TerminalData> terminals = await _terminalsRepository.getAllTerminals();

    if (terminals.length == 0) {
      return EmptyTerminalsManagerState();
    }

    _terminalsRepository.selectTerminal(terminals[0]);
    return LoadedTerminalsState(terminals, terminals[0]);
  }

  Future<TerminalsManagerState> _handleReceiveMessageFromTerminal(
      ReceiveMessageFromTerminalEvent event) async {
    try {
      ContractAction action = ContractAction.fromJsonString(event.message);
      _contractsBloc.dispatch(SendActionEvent(action));
    } on FormatException {
      print('Terminal sent an invalid action:' + event.message);
    }

    return currentState;
  }

  void _handleContractsStateChange(ContractsState state) {
    _terminalsRepository.sendContractsStateToTerminal(state);
  }

  @override
  void dispose() {
    super.dispose();
    _contractsBlocSubscription?.cancel();
  }
}
