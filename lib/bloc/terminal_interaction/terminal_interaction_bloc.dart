import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_event.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_state.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_state_after_query.dart';
import 'package:wetonomy/repositories/terminal_interaction_repository.dart';
import 'package:wetonomy/services/webview_terminal_service.dart';

import '../../models/contract.dart';

class TerminalInteractionBloc
    extends Bloc<TerminalInteractionEvent, TerminalInteractionState> {
  final WebViewTerminalService _service;
  final TerminalInteractionRepository repository;
  final TerminalsManagerBloc _terminalsManagerBloc;
  StreamSubscription<TerminalsManagerState> _terminalsManagerSubscription;
  StreamSubscription<ContractStateUpdateEvent> _contractStateUpdateSubscription;

  TerminalInteractionBloc(this.repository,
      this._service, this._terminalsManagerBloc) {

    _terminalsManagerSubscription =
        _terminalsManagerBloc.state.listen((TerminalsManagerState state) {
      if (state is LoadedTerminalsManagerState) {
        dispatch(SelectedTerminalInteractionEvent(state.currentTerminal));
      }
    });
    

    _contractStateUpdateSubscription = repository.getContractsEventsStream().stream.listen((data) {
      _handleContractsStateChange(data.contract);
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      throw(error);
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
    } else 
    if (event is ReceiveQueryFromTerminalEvent) {
      yield await _handleReceiveQueryEvent(event);
    } else 
    if (event is SelectedTerminalInteractionEvent) {
      yield await _handleTerminalSelectedEvent(event);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _terminalsManagerSubscription.cancel();
  }

  void _handleContractsStateChange(Contract state) {
    _service.handleContractsStateChange(state);
  }

  Future<TerminalInteractionState> _handleReceiveActionEvent(ReceiveActionFromTerminalEvent event) async {
    Map<String,dynamic> actionResult = await repository.sendAction(event.action);
    var response = TerminalInteractionStateAfterAction(actionResult, null);
    _service.handleActionResponse(response);
    return response;
  }

  Future<TerminalInteractionState> _handleReceiveQueryEvent(ReceiveQueryFromTerminalEvent event) async {
    Map<String,dynamic> queryResult = await repository.sendQuery(event.query);
    var response = TerminalInteractionStateAfterQuery(queryResult, event.query);
    _service.handleQueryResponse(response);
    return response;
  }

  Future<TerminalInteractionState> _handleTerminalSelectedEvent(
      SelectedTerminalInteractionEvent event) async {
    _service.selectTerminal(event.terminal);
    return ActiveTerminalInteractionState(event.terminal);
  }
}
