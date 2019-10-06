import 'dart:async';

import 'package:wetonomy/models/action_result.dart';
import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/models/action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/models/query_result.dart';
import 'package:wetonomy/services/contracts_api_client.dart';

class FakeContractsApiClient implements ContractsApiClient {
  static int count = 0;

  @override
  Future<ActionResult> sendAction(Action action) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ActionResult({'count': count++}, action);
  }

  @override
  Future<QueryResult> sendQuery(Query query) async {
    await Future.delayed(Duration(milliseconds: 500));
    return QueryResult({'count': count++}, query);
  }

  @override
  Stream<Contract> get contractsEventsStream => Stream.empty();
}
