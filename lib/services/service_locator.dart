import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/repositories/terminals_repository.dart';
import 'package:wetonomy/services/terminal_controller.dart';
import 'package:wetonomy/services/shared_preferences_terminals_dao.dart';
import 'package:wetonomy/services/strongforce_api_client_cosmos.dart';
import 'package:wetonomy/repositories/repositories.dart';

GetIt locator = GetIt();

Future<void> setupLocator() async {
  await _registerTerminalsRepository();
  _registerTerminalController();
}

Future<void> _registerTerminalsRepository() async {
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  final terminalManager = SharedPreferencesTerminalsDao(sharedPrefs);
  final apiClient = StrongForceApiClientCosmos();
  locator.registerSingleton<TerminalsRepository>(
      TerminalsRepository(terminalManager, apiClient));
}

void _registerTerminalController() {
  final controller = TerminalController(FlutterWebviewPlugin());
  locator.registerSingleton<TerminalController>(controller);
}