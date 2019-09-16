import 'dart:async';

import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_event.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/services/contracts_api_client.dart';


class TerminalInteractionRepository {
  final ContractsApiClient _client;
  

  TerminalInteractionRepository(this._client) : assert(_client != null);

  Future<Map<String,dynamic>> sendAction(ContractAction action) async {
    return await _client.sendAction(action);
  }

  Future<Map<String,dynamic>> sendQuery(Query query) async {
    return await _client.sendQuery(query);
  }

  StreamController<ContractStateUpdateEvent> getContractsEventsStream() {
    return _client.getContractsEventsStream();
  }
}
