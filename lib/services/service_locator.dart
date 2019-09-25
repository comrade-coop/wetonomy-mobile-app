import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/repositories/terminals_repository.dart';
import 'package:wetonomy/services/fake_contracts_api_client.dart';
import 'package:wetonomy/services/shared_preferences_terminals_dao.dart';
import 'package:wetonomy/services/strongforce_api_client_cosmos.dart';
import 'package:wetonomy/repositories/repositories.dart';

GetIt locator = GetIt();

Future<void> setupServiceLocator() async {
  await _registerTerminalsRepository();
}

Future<void> _registerTerminalsRepository() async {
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  final terminalManager = SharedPreferencesTerminalsDao(sharedPrefs);
  final apiClient = FakeContractsApiClient();
  locator.registerSingleton<TerminalsRepository>(
      TerminalsRepository(terminalManager, apiClient));
}
