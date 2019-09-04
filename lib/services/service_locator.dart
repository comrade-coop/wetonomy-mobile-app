import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/repositories/terminals_repository.dart';
import 'package:wetonomy/services/webview_terminal_reference_provider.dart';
import 'package:wetonomy/services/shared_preferences_terminal_storage_provider.dart';
import 'package:wetonomy/services/mock_strongforce_api_provider.dart';
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
  final apiClient = MockStrongForceApiProvider();
  locator
      .registerSingleton<ContractsRepository>(ContractsRepository(apiClient));
}

Future<void> _registerTerminalsRepository() async {
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  final terminalManager = SharedPrefsTerminalStorageProvider(sharedPrefs);
  final terminalFacade = WebviewPluginTerminalFacade();
  locator.registerSingleton<TerminalsRepository>(
      TerminalsRepository(terminalManager, terminalFacade));
}
