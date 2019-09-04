import 'package:wetonomy/models/terminal_data.dart';

abstract class TerminalStorageManager {
  Future<bool> addTerminal(TerminalData terminal);

  Future<bool> removeTerminal(TerminalData terminal);

  Future<List<TerminalData>> getAllTerminals();
}
