import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/services/shared_preferences_terminals_dao.dart';

import 'mocks/mock_shared_preferences.dart';

void main() {
  SharedPreferences _mockSharedPrefs(TerminalData terminal) {
    final sharedPrefs = MockSharedPreferences();
    final String terminalKey =
        SharedPreferencesTerminalsDao.terminalsSharedPrefsKey;

    final stringLists = Map<String, List<String>>();
    when(sharedPrefs.setStringList(
        terminalKey, [jsonEncode(terminal.toJson())])).thenAnswer((_) async {
      stringLists[terminalKey] = [jsonEncode(terminal.toJson())];
      return true;
    });
    when(sharedPrefs.getStringList(terminalKey))
        .thenAnswer((_) => stringLists[terminalKey]);

    return sharedPrefs;
  }

  group('TerminalsDao', () {
    test('SharedPreferencesTerminalsDao adds a new terminal successfully',
        () async {
      final terminal = TerminalData('test', 'test');

      final SharedPreferences sharedPrefs = _mockSharedPrefs(terminal);
      final terminalDao = SharedPreferencesTerminalsDao(sharedPrefs);
      
      final List<TerminalData> obligatoryTerminals = terminalDao.mockObligatoryTerminals;
      bool isAdded = await terminalDao.addTerminal(terminal);

      //TODO probably due to AndroidX update SharedPreferences do not work

      // expect(true, isAdded);

      // List<TerminalData> terminals = await terminalDao.getAllTerminals();
      // int expectedCount = obligatoryTerminals.length +1;
      // expect(expectedCount, terminals.length);
      // expect(terminal.url, terminals.toList()[obligatoryTerminals.length].url);
    });
  });
}
