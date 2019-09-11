import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_event.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_state.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/services/terminal_facade.dart';

class TerminalInteractionBloc
    extends Bloc<TerminalInteractionEvent, TerminalInteractionState> {
  final TerminalFacade _facade;
  final ContractsBloc _contractsBloc;
  final TerminalsManagerBloc _terminalsManagerBloc;
  StreamSubscription<ContractsState> _contractsBlocSubscription;
  StreamSubscription<TerminalsManagerState> _terminalsManagerSubscription;

  TerminalInteractionBloc(
      this._facade, this._terminalsManagerBloc, this._contractsBloc) {
    _contractsBlocSubscription =
        _contractsBloc.state.listen(_handleContractsStateChange);

    _terminalsManagerSubscription =
        _terminalsManagerBloc.state.listen((TerminalsManagerState state) {
      if (state is LoadedTerminalsManagerState) {
        dispatch(SelectedTerminalInteractionEvent(state.currentTerminal));
      }
    });
  }

  @override
  TerminalInteractionState get initialState =>
      InitialTerminalInteractionState();

  @override
  Stream<TerminalInteractionState> mapEventToState(
    TerminalInteractionEvent event,
  ) async* {
    if (event is ReceiveMessageTerminalInteractionEvent) {
      yield await _handleReceiveMessageFromTerminal(event);
    } else if (event is SelectedTerminalInteractionEvent) {
      yield await _handleTerminalSelectedEvent(event);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _contractsBlocSubscription.cancel();
    _terminalsManagerSubscription.cancel();
  }

  void _handleContractsStateChange(ContractsState state) {
    _facade.receiveContractsState(state);
  }

  Future<TerminalInteractionState> _handleReceiveMessageFromTerminal(
      ReceiveMessageTerminalInteractionEvent event) async {
    try {
      ContractAction action = ContractAction.fromJsonString(event.message);
      _contractsBloc.dispatch(SendActionContractsEvent(action));
    } on FormatException {
      print('Terminal sent an invalid action:' + event.message);
    }

    return currentState;
  }

  Future<TerminalInteractionState> _handleTerminalSelectedEvent(
      SelectedTerminalInteractionEvent event) async {
    _facade.selectTerminal(event.terminal);
    return ActiveTerminalInteractionState(event.terminal);
  }
}
