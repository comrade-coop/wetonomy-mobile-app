import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/repositories/terminals_repository.dart';
import 'package:wetonomy/services/shared_preferences_terminal_manager.dart';
import 'package:wetonomy/services/strongforce_api_client_mock.dart';
import 'package:wetonomy/repositories/contracts_repository.dart';

GetIt locator = GetIt();

Future<void> setupLocator() async {
  await _registerContractsRepository();
  await _registerTerminalsRepository();
  await _registerFlutterWebViewPlugin();
}

Future<void> _registerFlutterWebViewPlugin() async {
  final webViewPlugin = FlutterWebviewPlugin();
  locator.registerSingleton<FlutterWebviewPlugin>(webViewPlugin);
}

Future<void> _registerContractsRepository() async {
  final apiClient = StrongForceApiClientMock();
  locator
      .registerSingleton<ContractsRepository>(ContractsRepository(apiClient));
}

Future<void> _registerTerminalsRepository() async {
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  final terminalManager = SharedPreferencesTerminalManager(sharedPrefs);
  locator.registerSingleton<TerminalsRepository>(
      TerminalsRepository(terminalManager));
}
