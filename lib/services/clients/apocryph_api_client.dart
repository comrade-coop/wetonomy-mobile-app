import 'dart:async';

import 'package:wetonomy/models/action_result.dart';
import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/models/action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/models/query_result.dart';
import 'package:wetonomy/services/clients/contracts_api_client.dart';

import 'dummy_data.dart';

class ApocryphApiClient implements ContractsApiClient {
  static int count = 0;

  @override
  Future<ActionResult> sendAction(Action action) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ActionResult({'count': count++}, action);
  }

  @override
  Future<QueryResult> sendQuery(Query query) async {
    if (query.contractAddress == "GroupsAndMembersFactory")
      return QueryResult({
        'groups': groups,
        'members': members,
        'currentUserMetaData': currentUserMetaData
      }, query);
  }

  @override
  Stream<Contract> get contractsEventsStream => Stream.empty();
}
