import 'dart:convert';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/models/action_result.dart';
import 'package:wetonomy/models/query_result.dart';
import 'package:wetonomy/models/terminal_data.dart';

import '../bloc/terminal_interaction/terminal_interaction_state.dart';
import '../models/contract.dart';

class TerminalController {
  static const String _receiveStateUpdateMethodName =
      'StrongForce__receiveStateUpdate';

  static const String _receiveQueryResponseMethodName =
      'StrongForce__receiveQueryResponse';

  static const String _receiveActionResponseMethodName =
      'StrongForce__receiveActionResponse';

  final FlutterWebviewPlugin _webViewPlugin;

  TerminalController(this._webViewPlugin) : assert(_webViewPlugin != null);

  void selectTerminal(TerminalData terminal) {
    _hideAndShowWhenLoaded();
    _webViewPlugin.reloadUrl(terminal.url);
  }

  void handleContractsStateChange(Contract contract) {
    String contractsStateJson = jsonEncode(contract.toJson());
    _webViewPlugin.evalJavascript(
        _receiveStateUpdateMethodName + '(\'$contractsStateJson\');');
  }

  void handleQueryResult(QueryResult result) {
    String queryResponse = jsonEncode(result.toJson());
    _webViewPlugin.evalJavascript(
        _receiveQueryResponseMethodName + '(\'$queryResponse\');');
  }

  void handleActionResult(ActionResult result) {
    String actionResponse = jsonEncode(result.toJson());
    _webViewPlugin.evalJavascript(
        _receiveActionResponseMethodName + '(\'$actionResponse\');');
  }

  void _hideAndShowWhenLoaded() async {
    _webViewPlugin.hide();

    await this._webViewPlugin.onStateChanged.firstWhere(
        (WebViewStateChanged newState) =>
            newState.type == WebViewState.finishLoad);

    _webViewPlugin.show();
  }
}
