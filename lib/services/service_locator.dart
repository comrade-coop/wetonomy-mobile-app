import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/services/shared_preferences_terminal_manager.dart';
import 'package:wetonomy/services/strongforce_api_client_mock.dart';
import 'package:wetonomy/repositories/strongforce_repository.dart';

GetIt locator = GetIt();

Future<void> setupLocator() async {
  await _setupRepository();
}

Future<void> _setupRepository() async {
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  final apiClient = StrongForceApiClientMock();
  final terminalManager = SharedPreferencesTerminalManager(sharedPrefs);

  locator.registerSingleton<StrongForceRepository>(
      StrongForceRepository(apiClient, terminalManager));
}
