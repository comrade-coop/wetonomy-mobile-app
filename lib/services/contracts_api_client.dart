import 'dart:async';

import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_event.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/query.dart';


class ContractsApiClient {
  // ignore: missing_return
  Future<Map<String,dynamic>> sendAction(ContractAction action) async {}

  // ignore: missing_return
  Future<Map<String,dynamic>> sendQuery(Query query) async {}

  // ignore: missing_return
  StreamController<ContractStateUpdateEvent> getContractsEventsStream() {}
}
