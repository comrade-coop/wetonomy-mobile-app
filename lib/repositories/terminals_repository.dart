import 'package:wetonomy/bloc/contracts/contracts_state.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/services/terminal_facade.dart';
import 'package:wetonomy/services/terminal_storage_provider.dart';

class TerminalsRepository {
  final TerminalStorageProvider _storageProvider;
  final TerminalFacade _terminalFacade;

  TerminalsRepository(this._storageProvider, this._terminalFacade);

  Stream<TerminalLoadState> get onTerminalLoadStateChanged =>
      _terminalFacade.onTerminalLoadStateChanged;

  Future<List<TerminalData>> getAllTerminals() {
    return _storageProvider.getAllTerminals();
  }

  Future<bool> addTerminal(TerminalData terminal) {
    return _storageProvider.addTerminal(terminal);
  }

  Future<bool> removeTerminal(TerminalData terminal) {
    return _storageProvider.removeTerminal(terminal);
  }

  void sendContractsStateToTerminal(ContractsState state) {
    _terminalFacade.receiveContractsState(state);
  }

  void selectTerminal(TerminalData terminal) {
    _terminalFacade.selectTerminal(terminal);
  }
}
