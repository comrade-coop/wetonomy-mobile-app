import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/services/terminal_manager.dart';

class MockTerminalManager implements TerminalManager {
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
