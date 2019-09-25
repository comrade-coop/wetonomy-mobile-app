import 'package:flutter_test/flutter_test.dart';
import 'package:wetonomy/models/models.dart';

void main() {
  group('ContractAction', () {
    test('Creates correct action from json string', () {
      final String json = '''{
        "Targets": ["0x00000000000000000000"],
        "Type": "CreateAchievement",
        "Payload": {"Title": "test", "Description": "x"}
      }''';

      final expected = Action(['0x00000000000000000000'],
          'CreateAchievement', {'Title': "test", 'Description': "x"});

      final result = Action.fromJsonString(json);
      expect(expected, result);
    });

    test('Throws when invalid json is sent', () {
      // Missing opening brace
      final String json = '''
        "targets": "CreateAchievement",
        "payload: ["Title", "Description"]
      }''';
      expect(() => Action.fromJsonString(json), throwsFormatException);
    });

    test('Throws when invalid action is sent', () {
      // Missing payload
      final String json = '''{
        "Targets": "0x00000000000000000000",
        "Type": "CreateAchievement",
      }''';

      expect(() => Action.fromJsonString(json), throwsFormatException);
    });
  });
}
