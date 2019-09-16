import 'dart:async';

import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/query.dart';

abstract class ContractsApiClient {
  Future<Map<String, dynamic>> sendAction(ContractAction action);

  Future<Map<String, dynamic>> sendQuery(Query query);

  Stream<Contract> get contractsEventsStream;
}
