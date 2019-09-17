import 'package:flutter_test/flutter_test.dart';
import 'package:wetonomy/models/models.dart';

void main() {
  group('ContractAction', () {
    test('Creates correct action from json string', () {
      final String json = '''{
        "targets": ["0x00000000000000000000"],
        "actionName": "CreateAchievement",
        "parameters": {"Title": "test", "Description": "x"}
      }''';

      final expected = Action(['0x00000000000000000000'],
          'CreateAchievement', {'Title': "test", 'Description': "x"});

      final result = Action.fromJsonString(json);
      expect(expected, result);
    });

    test('Throws when invalid json is sent', () {
      final String json = '''
        "actionName": "CreateAchievement",
        "parameters: ["Title", "Description"]
      }''';
      expect(() => Action.fromJsonString(json), throwsFormatException);
    });

    test('Throws when invalid action is sent', () {
      final String json = '''{
        "target": "0x00000000000000000000",
        "actionName": "CreateAchievement",
      }''';

      expect(() => Action.fromJsonString(json), throwsFormatException);
    });
  });
}
