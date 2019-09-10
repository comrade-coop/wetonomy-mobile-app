import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_event.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_state.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/repositories/repositories.dart';

class TerminalInteractionBloc
    extends Bloc<TerminalInteractionEvent, TerminalInteractionState> {

  final TerminalsRepository _terminalsRepository;
  final ContractsBloc _contractsBloc;

  StreamSubscription<ContractsState> _contractsBlocSubscription;

  TerminalInteractionBloc(this._terminalsRepository, this._contractsBloc)
      : assert(_terminalsRepository != null),
        assert(_contractsBloc != null) {
    _contractsBlocSubscription = _contractsBloc.state
        .listen(_terminalsRepository.sendContractsStateToTerminal);
  }

  @override
  TerminalInteractionState get initialState =>
      InitialTerminalInteractionState();

  @override
  Stream<TerminalInteractionState> mapEventToState(
    TerminalInteractionEvent event,
  ) async* {
    if (event is ReceiveMessageFromTerminalEvent) {
      yield await _handleReceiveMessageFromTerminal(event);
    }
  }

  Future<TerminalInteractionState> _handleReceiveMessageFromTerminal(
      ReceiveMessageFromTerminalEvent event) async {
    try {
      ContractAction action = ContractAction.fromJsonString(event.message);
      _contractsBloc.dispatch(SendActionEvent(action));
    } on FormatException {
      print('Terminal sent an invalid action:' + event.message);
    }

    return currentState;
  }

  @override
  void dispose() {
    super.dispose();
    _contractsBlocSubscription?.cancel();
  }
}
