import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_state_after_query.dart';
import 'package:wetonomy/models/terminal_data.dart';

import '../bloc/terminal_interaction/terminal_interaction_state.dart';
import '../models/contract.dart';

class WebViewTerminalService {
  static const String strongForceReceiveStateUpdateMethodName =
    'StrongForce__receiveStateUpdateFromNative';

  static const String strongForceReceiveQueryMethodName =
    'StrongForce__receiveQueryResponseFromNative';

  static const String snackbarNotificationMethodName =
    'StrongForce__snackbarNotification';

  final FlutterWebviewPlugin _webViewPlugin;

  WebViewTerminalService(this._webViewPlugin) : assert(_webViewPlugin != null);

  void selectTerminal(TerminalData terminal) {
    _hideAndShowWhenLoaded();
    _webViewPlugin.reloadUrl(terminal.url);
  }

  void _hideAndShowWhenLoaded() async {
    _webViewPlugin.hide();

    await this._webViewPlugin.onStateChanged.firstWhere(
        (WebViewStateChanged newState) =>
            newState.type == WebViewState.finishLoad);

    _webViewPlugin.show();
  }

  void _sendStateUpdateToWebView(String message) {
    _webViewPlugin
        .evalJavascript(strongForceReceiveStateUpdateMethodName + '(\'$message\');');
  }

  void _sendQueryToWebView(String message) {
    _webViewPlugin
        .evalJavascript(strongForceReceiveQueryMethodName + '(\'$message\');');
  }

  void _sendSnackbarNotificationToWebView(String message) {
    _webViewPlugin
        .evalJavascript(snackbarNotificationMethodName + '(\'$message\');');
  }

  void handleContractsStateChange(Contract state) {
    String contractsStateJson = state.toEncodedJson();
    _sendStateUpdateToWebView(contractsStateJson);
  }

  void handleQueryResponse(TerminalInteractionStateAfterQuery state) {
    String interactionResponseJson = state.toEncodedJson();
    _sendQueryToWebView(interactionResponseJson);
  }

  void handleActionResponse(TerminalInteractionStateAfterAction state) {
    String interactionResponseJson = state.toEncodedJson();
    _sendSnackbarNotificationToWebView(interactionResponseJson);
    
  }
}
