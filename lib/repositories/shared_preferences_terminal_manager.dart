import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/models/terminal.dart';

import './terminal_manager.dart';

class SharedPreferencesTerminalManager implements TerminalManager {
  static const String TERMINAL_SHARED_PREFS_KEY = "terminals_key";

  final SharedPreferences sharedPrefs;

  SharedPreferencesTerminalManager(this.sharedPrefs)
      : assert(sharedPrefs != null);

  @override
  Future<bool> addTerminal(Terminal terminal) async {
    Set<Terminal> terminals = await getAllTerminals();
    terminals.add(terminal);
    return _setTerminals(terminals);
  }

  @override
  Future<Set<Terminal>> getAllTerminals() async {
    List<String> terminalStrings =
        sharedPrefs.getStringList(TERMINAL_SHARED_PREFS_KEY);
    Set<Terminal> terminals = terminalStrings.map((s) {
      return Terminal(s);
    }).toSet();
    return terminals;
  }

  @override
  Future<bool> removeTerminal(Terminal terminal) async {
    Set<Terminal> terminals = await getAllTerminals();
    terminals.remove(terminal);
    return _setTerminals(terminals);
  }

  Future<bool> _setTerminals(Set<Terminal> terminals) async {
    sharedPrefs.setStringList(
        TERMINAL_SHARED_PREFS_KEY,
        terminals.map((t) {
          return t.toString();
        }).toList());
    return true;
  }
}
