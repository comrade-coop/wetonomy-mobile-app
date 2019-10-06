import 'dart:async';

import 'package:wetonomy/models/action_result.dart';
import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/models/action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/models/query_result.dart';

abstract class ContractsApiClient {
  Future<ActionResult> sendAction(Action action);

  Future<QueryResult> sendQuery(Query query);

  Stream<Contract> get contractsEventsStream;
}
