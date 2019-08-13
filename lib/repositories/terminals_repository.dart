import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/services/terminal_manager.dart';

class TerminalsRepository {
  final TerminalManager _terminalManager;

  TerminalsRepository(this._terminalManager);

  Future<List<TerminalData>> getAllTerminals() {
    return _terminalManager.getAllTerminals();
  }

  Future<bool> addTerminal(TerminalData terminal) {
    return _terminalManager.addTerminal(terminal);
  }

  Future<bool> removeTerminal(TerminalData terminal) {
    return _terminalManager.removeTerminal(terminal);
  }
}
