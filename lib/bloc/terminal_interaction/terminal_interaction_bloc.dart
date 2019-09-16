import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_event.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_state.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_state_after_query.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/repositories/repositories.dart';
import 'package:wetonomy/services/webview_terminal_bridge.dart';

import '../../models/contract.dart';

class TerminalInteractionBloc
    extends Bloc<TerminalInteractionEvent, TerminalInteractionState> {
  final TerminalBridge _webViewBridge;
  final TerminalsRepository repository;
  final TerminalsManagerBloc _terminalsManagerBloc;
  StreamSubscription<TerminalsManagerState> _terminalsManagerSubscription;
  StreamSubscription<Contract> _contractStateUpdateSubscription;

  TerminalInteractionBloc(
      this.repository, this._webViewBridge, this._terminalsManagerBloc) {
    _terminalsManagerSubscription =
        _terminalsManagerBloc.state.listen((TerminalsManagerState state) {
      if (state is LoadedTerminalsManagerState) {
        dispatch(SelectedTerminalInteractionEvent(state.currentTerminal));
      }
    });

    _contractStateUpdateSubscription =
        repository.contractsEventsStream.listen((Contract contract) {
      _handleContractsStateChange(contract);
    }, onDone: () {
      print('Task Done');
    }, onError: (error) {
      throw (error);
    });
  }

  @override
  TerminalInteractionState get initialState =>
      InitialTerminalInteractionState();

  @override
  Stream<TerminalInteractionState> mapEventToState(
    TerminalInteractionEvent event,
  ) async* {
    if (event is ReceiveActionFromTerminalEvent) {
      yield await _handleReceiveActionEvent(event);
    } else if (event is ReceiveQueryFromTerminalEvent) {
      yield await _handleReceiveQueryEvent(event);
    } else if (event is SelectedTerminalInteractionEvent) {
      yield await _handleTerminalSelectedEvent(event);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _terminalsManagerSubscription.cancel();
    _contractStateUpdateSubscription.cancel();
  }

  void _handleContractsStateChange(Contract state) {
    _webViewBridge.handleContractsStateChange(state);
  }

  Future<TerminalInteractionState> _handleReceiveActionEvent(
      ReceiveActionFromTerminalEvent event) async {
    try {
      final ContractAction action =
          ContractAction.fromJsonString(event.serialisedAction);

      final Map<String, dynamic> actionResult =
          await repository.sendAction(action);
      final response = TerminalInteractionStateAfterAction(actionResult, null);
      _webViewBridge.handleActionResponse(response);
      return response;
    } on FormatException {
      print('Terminal sent an invalid action:' + event.serialisedAction);
    }

    return currentState;
  }

  Future<TerminalInteractionState> _handleReceiveQueryEvent(
      ReceiveQueryFromTerminalEvent event) async {
    try {
      final query = Query.fromJsonString(event.serialisedQuery);

      Map<String, dynamic> queryResult = await repository.sendQuery(query);
      final response = TerminalInteractionStateAfterQuery(queryResult, query);
      _webViewBridge.handleQueryResponse(response);
      return response;
    } on FormatException {
      print('Terminal sent an invalid action:' + event.serialisedQuery);
    }

    return currentState;
  }

  Future<TerminalInteractionState> _handleTerminalSelectedEvent(
      SelectedTerminalInteractionEvent event) async {
    _webViewBridge.selectTerminal(event.terminal);
    return ActiveTerminalInteractionState(event.terminal);
  }
}
