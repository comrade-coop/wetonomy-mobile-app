import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/terminal_interaction/received_query_result_state.dart';
import 'package:wetonomy/models/terminal_data.dart';

import '../bloc/terminal_interaction/terminal_interaction_state.dart';
import '../models/contract.dart';

class TerminalController {
  static const String _receiveStateUpdateMethodName =
      'StrongForce__receiveStateUpdateFromNative';

  static const String _receiveQueryResponseMethodName =
      'StrongForce__receiveQueryResponseFromNative';

  static const String _receiveActionResponseMethodName =
      'StrongForce__snackbarNotification';

  final FlutterWebviewPlugin _webViewPlugin;

  TerminalController(this._webViewPlugin) : assert(_webViewPlugin != null);

  void selectTerminal(TerminalData terminal) {
    _hideAndShowWhenLoaded();
    _webViewPlugin.reloadUrl(terminal.url);
  }

  void handleContractsStateChange(Contract state) {
    String contractsStateJson = state.toEncodedJson();
    _webViewPlugin.evalJavascript(
        _receiveStateUpdateMethodName + '(\'$contractsStateJson\');');
  }

  void handleQueryResponse(ReceivedQueryResultState state) {
    String queryResponse = state.toEncodedJson();
    _webViewPlugin.evalJavascript(
        _receiveQueryResponseMethodName + '(\'$queryResponse\');');
  }

  void handleActionResponse(ReceivedActionResultState state) {
    String actionResponse = state.toEncodedJson();
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
