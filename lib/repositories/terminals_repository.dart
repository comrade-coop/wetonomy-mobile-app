import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/services/terminal_storage_provider.dart';

class TerminalsRepository {
  final TerminalStorageProvider _storageProvider;

  TerminalsRepository(this._storageProvider);

  Future<List<TerminalData>> getAllTerminals() {
    return _storageProvider.getAllTerminals();
  }

  Future<bool> addTerminal(TerminalData terminal) {
    return _storageProvider.addTerminal(terminal);
  }

  Future<bool> removeTerminal(TerminalData terminal) {
    return _storageProvider.removeTerminal(terminal);
  }
}
