import 'dart:async';

import 'package:wetonomy/models/action_result.dart';
import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/models/action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/models/query_result.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/services/contracts_api_client.dart';
import 'package:wetonomy/services/terminals_dao.dart';

class TerminalsRepository {
  final TerminalsDao _terminalsDao;
  final ContractsApiClient _client;

  TerminalsRepository(this._terminalsDao, this._client);

  Future<List<TerminalData>> getAllTerminals() {
    return _terminalsDao.getAllTerminals();
  }

  Future<bool> addTerminal(TerminalData terminal) {
    return _terminalsDao.addTerminal(terminal);
  }

  Future<bool> removeTerminal(TerminalData terminal) {
    return _terminalsDao.removeTerminal(terminal);
  }

  Future<ActionResult> sendAction(Action action) async {
    return await _client.sendAction(action);
  }

  Future<QueryResult> sendQuery(Query query) async {
    return await _client.sendQuery(query);
  }

  Stream<Contract> get contractsEventsStream => _client.contractsEventsStream;
}
