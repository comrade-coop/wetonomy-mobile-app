import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/models/terminal_data.dart';

import './terminal_manager.dart';

class SharedPreferencesTerminalManager implements TerminalStorageManager {
  static const String TERMINAL_SHARED_PREFS_KEY = "terminals_key";

  final SharedPreferences sharedPrefs;

  SharedPreferencesTerminalManager(this.sharedPrefs)
      : assert(sharedPrefs != null);

  @override
  Future<bool> addTerminal(TerminalData terminal) async {
    List<TerminalData> terminals = await getAllTerminals();
    if (terminals.contains(terminal)) {
      return false;
    }
    terminals.add(terminal);
    return _setTerminals(terminals);
  }

  @override
  Future<List<TerminalData>> getAllTerminals() async {
    List<String> terminalStrings =
        sharedPrefs.getStringList(TERMINAL_SHARED_PREFS_KEY);
    List<TerminalData> terminals = terminalStrings != null
        ? terminalStrings.map((url) => TerminalData(url, [])).toList()
        : new List<TerminalData>();
    return terminals;
  }

  @override
  Future<bool> removeTerminal(TerminalData terminal) async {
    List<TerminalData> terminals = await getAllTerminals();
    bool wasRemoved = terminals.remove(terminal);
    return wasRemoved && await _setTerminals(terminals);
  }

  Future<bool> _setTerminals(List<TerminalData> terminals) async {
    List<String> terminalUrls = terminals.map((t) {
      return t.url;
    }).toList();
    return sharedPrefs.setStringList(TERMINAL_SHARED_PREFS_KEY, terminalUrls);
  }
}
