import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_event.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_state.dart';
import 'package:wetonomy/bloc/terminal_interaction/received_query_result_state.dart';
import 'package:wetonomy/models/action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/repositories/repositories.dart';

import '../../models/contract.dart';

class TerminalInteractionBloc
    extends Bloc<TerminalInteractionEvent, TerminalInteractionState> {
  final TerminalsRepository repository;
  final TerminalsManagerBloc _terminalsManagerBloc;
  StreamSubscription<TerminalsManagerState> _terminalsManagerSubscription;
  StreamSubscription<Contract> _contractStateUpdateSubscription;

  TerminalInteractionBloc(this.repository, this._terminalsManagerBloc) {
    _terminalsManagerSubscription =
        _terminalsManagerBloc.state.listen((TerminalsManagerState state) {
      if (state is LoadedTerminalsManagerState) {
        dispatch(SelectedTerminalInteractionEvent(state.currentTerminal));
      }
    });

    _contractStateUpdateSubscription =
        repository.contractsEventsStream.listen((Contract contract) {
      dispatch(ContractChangedEvent(contract));
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
      yield SelectedTerminalState(event.terminal);
    } else if (event is ContractChangedEvent) {
      yield ContractStateChangedState(event.contract);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _terminalsManagerSubscription.cancel();
    _contractStateUpdateSubscription.cancel();
  }

  Future<TerminalInteractionState> _handleReceiveActionEvent(
      ReceiveActionFromTerminalEvent event) async {
    try {
      final Action action = Action.fromJsonString(event.serialisedAction);

      final Map<String, dynamic> actionResult =
          await repository.sendAction(action);
      final state = ReceivedActionResultState(actionResult, null);
      return state;
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
      final state = ReceivedQueryResultState(queryResult, query);
      return state;
    } on FormatException {
      print('Terminal sent an invalid action:' + event.serialisedQuery);
    }

    return currentState;
  }
}
