import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/repositories/strongforce_api_client.dart';
import 'package:wetonomy/repositories/terminal_manager.dart';

class StrongForceRepository {
  final StrongForceApiClient _client;
  final TerminalManager _terminalManager;

  StrongForceRepository(this._client, this._terminalManager)
      : assert(_client != null),
        assert(_terminalManager != null);

  Future<bool> sendAction(ContractAction action) async {
    final bool result = await _client.sendAction(action);
    return result;
  }

  Future<bool> sendQuery(Query query) async {
    final bool result = await _client.sendQuery(query);
    return result;
  }

  Future<bool> addTerminal(TerminalData terminal) {
    return _terminalManager.addTerminal(terminal);
  }

  Future<bool> removeTerminal(TerminalData terminal) {
    return _terminalManager.removeTerminal(terminal);
  }

  Future<Set<TerminalData>> getAllTerminals() {
    return _terminalManager.getAllTerminals();
  }
}
