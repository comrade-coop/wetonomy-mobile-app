import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_event.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_state.dart';
import 'package:wetonomy/models/action_result.dart';
import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/models/query_result.dart';
import 'package:wetonomy/repositories/repositories.dart';

class TerminalInteractionBloc
    extends Bloc<TerminalInteractionEvent, TerminalInteractionState> {
  final TerminalsRepository repository;
  // final TerminalsManagerBloc _terminalsManagerBloc;
  StreamSubscription<TerminalsManagerState> _terminalsManagerSubscription;
  StreamSubscription<Contract> _contractStateUpdateSubscription;

  TerminalInteractionBloc(this.repository) {
    // _terminalsManagerSubscription =
    //     _terminalsManagerBloc.state.listen((TerminalsManagerState state) {
    //   if (state is LoadedTerminalsManagerState) {
    //     dispatch(SelectedTerminalInteractionEvent(state.currentTerminal));
    //   }
    // });

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
      yield ReceiveActionFromTerminalState();
      yield await _handleReceiveActionEvent(event);
    } else if (event is ReceiveQueryFromTerminalEvent) {
      yield await _handleReceiveQueryEvent(event);
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
      final ActionResult actionResult =
          await repository.sendAction(event.action);
      final state = ReceivedActionResultState(actionResult);
      return state;
    } on FormatException {
      print('Terminal sent an invalid action:' + event.action.toString());
    }

    return WaitingInteractionTerminalState();
  }

  Future<TerminalInteractionState> _handleReceiveQueryEvent(
      ReceiveQueryFromTerminalEvent event) async {
    try {
      final query = event.query;

      QueryResult queryResult = await repository.sendQuery(query);
      final state = ReceivedQueryResultState(queryResult);
      return state;
    } on FormatException {
      print('Terminal sent an invalid query:' + event.query.toString());
    }

    return currentState;
  }
}
