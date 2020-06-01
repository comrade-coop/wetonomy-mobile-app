import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/models/terminal_data.dart';

import './terminals_dao.dart';

class SharedPreferencesTerminalsDao implements TerminalsDao {
  static const String terminalsSharedPrefsKey = "terminals_key";

  final SharedPreferences sharedPrefs;

  SharedPreferencesTerminalsDao(this.sharedPrefs) : assert(sharedPrefs != null);
  
  final List<TerminalData> mockObligatoryTerminals = [
    TerminalData("voting", "Decisions", nativeTerminal: true),
    TerminalData("groups", "Groups", nativeTerminal: true),
    // TerminalData("Achievements", "Achievements", nativeTerminal: false),
  ];

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
        ? terminalStrings
            .map((String terminalJson) =>
                TerminalData.fromJson(jsonDecode(terminalJson)))
            .toList()
        : new List<TerminalData>();
    // String url = await rootBundle.loadString('assets/build/index.html');
    // mockObligatoryTerminals[2] = TerminalData(Uri.dataFromString(url, mimeType: 'text/html').toString(), "Achievements");

    if (!terminals.contains(mockObligatoryTerminals[0])) {
      terminals.addAll(mockObligatoryTerminals);
    }
    

    return terminals;
  }

  @override
  Future<bool> removeTerminal(TerminalData terminal) async {
    List<TerminalData> terminals = await getAllTerminals();
    bool wasRemoved = terminals.remove(terminal);
    return wasRemoved && await _setTerminals(terminals);
  }

  Future<bool> _setTerminals(List<TerminalData> terminals) async {
    List<String> terminalsJson =
        terminals.map((t) => jsonEncode(t.toJson())).toList();
    return sharedPrefs.setStringList(terminalsSharedPrefsKey, terminalsJson);
  }
}
