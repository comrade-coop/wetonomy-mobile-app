import 'package:flutter_test/flutter_test.dart';
import 'package:wetonomy/models/models.dart';

void main() {
  group('ContractAction', () {
    test('Creates correct action from json string', () {
      final String json = '''{
        "target": "0x00000000000000000000",
        "actionName": "CreateAchievement",
        "parameters": ["Title", "Description"]
      }''';

      final expected = ContractAction(['0x00000000000000000000'],
          'CreateAchievement', {'Title': "", 'Description': ""});

      final result = ContractAction.fromJsonString(json);
      expect(expected, result);
    });

    test('Throws when invalid json is sent', () {
      final String json = '''
        "actionName": "CreateAchievement",
        "parameters: ["Title", "Description"]
      }''';
      expect(() => ContractAction.fromJsonString(json), throwsFormatException);
    });

    test('Throws when invalid action is sent', () {
      final String json = '''{
        "target": "0x00000000000000000000",
        "actionName": "CreateAchievement",
      }''';

      expect(() => ContractAction.fromJsonString(json), throwsFormatException);
    });
  });
}
