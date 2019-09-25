import 'dart:async';

import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/models/action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/services/contracts_api_client.dart';

class FakeContractsApiClient implements ContractsApiClient {
  static int count = 0;

  @override
  Future<Map<String, dynamic>> sendAction(Action action) async {
    await Future.delayed(Duration(milliseconds: 500));
    return { 'count': count++ };
  }

  @override
  Future<Map<String, dynamic>> sendQuery(Query query) async {
    await Future.delayed(Duration(milliseconds: 500));
      return { 'count': count++ };
  }

  @override
  Stream<Contract> get contractsEventsStream => Stream.empty();
}
