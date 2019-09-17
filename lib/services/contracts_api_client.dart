import 'dart:async';

import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/models/action.dart';
import 'package:wetonomy/models/query.dart';

abstract class ContractsApiClient {
  Future<Map<String, dynamic>> sendAction(Action action);

  Future<Map<String, dynamic>> sendQuery(Query query);

  Stream<Contract> get contractsEventsStream;
}
