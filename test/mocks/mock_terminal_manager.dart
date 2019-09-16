import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/services/terminals_dao.dart';

class MockTerminalManager implements TerminalsDao {
  final _terminals = Set<TerminalData>();

  @override
  Future<bool> addTerminal(TerminalData terminal) async {
    return _terminals.add(terminal);
  }

  @override
  Future<List<TerminalData>> getAllTerminals() async {
    return _terminals.toList();
  }

  @override
  Future<bool> removeTerminal(TerminalData terminal) async {
    return _terminals.remove(terminal);
  }
}
