import 'package:wetonomy/models/terminal_data.dart';

abstract class TerminalManager {
  // ignore: missing_return
  Future<bool> addTerminal(TerminalData terminal);

  // ignore: missing_return
  Future<bool> removeTerminal(TerminalData terminal);

  // ignore: missing_return
  Future<Set<TerminalData>> getAllTerminals();
}
