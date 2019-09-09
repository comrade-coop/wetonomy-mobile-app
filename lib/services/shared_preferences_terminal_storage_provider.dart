import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/models/terminal_data.dart';

import './terminal_storage_provider.dart';

class SharedPrefsTerminalStorageProvider implements TerminalStorageProvider {
  static const String terminalsSharedPrefsKey = "terminals_key";

  final SharedPreferences sharedPrefs;

  SharedPrefsTerminalStorageProvider(this.sharedPrefs)
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
        sharedPrefs.getStringList(terminalsSharedPrefsKey);

    List<TerminalData> terminals = terminalStrings != null
        ? terminalStrings.map((String terminalJson) =>
            TerminalData.fromJson(jsonDecode(terminalJson))).toList()
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
    List<String> terminalsJson = terminals.map((t) => t.toEncodedJson()).toList();
    return sharedPrefs.setStringList(terminalsSharedPrefsKey, terminalsJson);
  }
}
