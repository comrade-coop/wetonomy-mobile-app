import 'package:wetonomy/bloc/contracts/contracts_state.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/services/terminal_facade.dart';
import 'package:wetonomy/services/terminal_manager.dart';

class TerminalsRepository {
  final TerminalStorageManager _terminalManager;
  final TerminalFacade _terminalFacade;

  TerminalsRepository(this._terminalManager, this._terminalFacade);

  Future<List<TerminalData>> getAllTerminals() {
    return _terminalManager.getAllTerminals();
  }

  Future<bool> addTerminal(TerminalData terminal) {
    return _terminalManager.addTerminal(terminal);
  }

  Future<bool> removeTerminal(TerminalData terminal) {
    return _terminalManager.removeTerminal(terminal);
  }

  void sendContractsStateToTerminal(ContractsState state) {
    _terminalFacade.receiveContractsState(state);
  }

  void selectTerminal(TerminalData terminal) {
    _terminalFacade.loadTerminal(terminal);
  }
}
