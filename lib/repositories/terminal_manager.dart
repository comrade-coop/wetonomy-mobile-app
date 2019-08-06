import 'package:wetonomy/models/terminal.dart';

abstract class TerminalManager {
  // ignore: missing_return
  Future<bool> addTerminal(Terminal terminal);

  // ignore: missing_return
  Future<bool> removeTerminal(Terminal terminal);

  // ignore: missing_return
  Future<Set<Terminal>> getAllTerminals();
}
