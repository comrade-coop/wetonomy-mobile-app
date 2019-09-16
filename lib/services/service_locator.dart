import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/repositories/terminals_repository.dart';
import 'package:wetonomy/services/webview_terminal_service.dart';
import 'package:wetonomy/services/shared_preferences_terminal_storage_provider.dart';
import 'package:wetonomy/services/strongforce_api_client_cosmos.dart';
import 'package:wetonomy/repositories/repositories.dart';

GetIt locator = GetIt();

Future<void> setupLocator() async {
  await _registerTerminalsRepository();
  _registerContractsRepository();
  _registerTerminalFacade();
}

void _registerContractsRepository() {
  final apiClient = StrongForceApiClientCosmos();
  locator.registerSingleton<TerminalInteractionRepository>(TerminalInteractionRepository(apiClient));
}

Future<void> _registerTerminalsRepository() async {
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  final terminalManager = SharedPrefsTerminalStorageProvider(sharedPrefs);
  locator.registerSingleton<TerminalsRepository>(TerminalsRepository(terminalManager));
}

void _registerTerminalFacade() {
  final terminalFacade = WebViewTerminalService(FlutterWebviewPlugin());
  locator.registerSingleton<WebViewTerminalService>(terminalFacade);
}
