import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/repositories/terminals_repository.dart';
import 'package:wetonomy/services/webview_terminal_facade.dart';
import 'package:wetonomy/services/shared_preferences_terminal_storage_provider.dart';
import 'package:wetonomy/services/mock_contracts_api_client.dart';
import 'package:wetonomy/repositories/contracts_repository.dart';

GetIt locator = GetIt();

Future<void> setupLocator() async {
  await _registerContractsRepository();
  await _registerTerminalsRepository();
}

Future<void> _registerContractsRepository() async {
  final apiClient = MockContractsApiClient();
  locator
      .registerSingleton<ContractsRepository>(ContractsRepository(apiClient));
}

Future<void> _registerTerminalsRepository() async {
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  final terminalManager = SharedPrefsTerminalStorageProvider(sharedPrefs);
  final terminalFacade = WebViewTerminalFacade(FlutterWebviewPlugin());
  locator.registerSingleton<TerminalsRepository>(
      TerminalsRepository(terminalManager, terminalFacade));
}
