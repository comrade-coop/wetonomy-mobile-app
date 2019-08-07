import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/repositories/shared_preferences_terminal_manager.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('TerminalManager', () {
    test('SharedPreferencesTerminalManager adds a new terminal successfully',
        () async {
      final sharedPrefs = MockSharedPreferences();
      final terminalManager = SharedPreferencesTerminalManager(sharedPrefs);
      final term = TerminalData('test');

      when(sharedPrefs.getStringList('terminals_key')).thenReturn([term.url]);

      await terminalManager.addTerminal(term);

      Set<TerminalData> terminals = await terminalManager.getAllTerminals();

      expect(1, terminals.length);
      expect(term.url, terminals.toList()[0].url);
    });
  });
}
