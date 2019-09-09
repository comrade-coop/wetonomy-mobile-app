import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/services/shared_preferences_terminal_storage_provider.dart';

import 'mocks/mock_shared_preferences.dart';

void main() {
  group('TerminalManager', () {
    test('SharedPreferencesTerminalManager adds a new terminal successfully',
        () async {
      final sharedPrefs = MockSharedPreferences();
      final terminalManager = SharedPrefsTerminalStorageProvider(sharedPrefs);
      final term = TerminalData('test', []);
      final String terminalKey =
          SharedPrefsTerminalStorageProvider.TERMINAL_SHARED_PREFS_KEY;

      await terminalManager.addTerminal(term);

      Map<String, List<String>> stringLists;
      when(sharedPrefs.setStringList(terminalKey, [term.url]))
          .thenAnswer((_) async {
        stringLists[terminalKey] = [term.url];
        return true;
      });
      when(sharedPrefs.getStringList(terminalKey))
          .thenAnswer((_) => [term.url]);

      List<TerminalData> terminals = await terminalManager.getAllTerminals();

      expect(1, terminals.length);
      expect(term.url, terminals.toList()[0].url);
    });
  });
}
