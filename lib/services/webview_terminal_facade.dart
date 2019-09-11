import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/services/terminal_facade.dart';

class WebViewTerminalFacade implements TerminalFacade {
  static const String strongForceReceiveMethodName =
      'StrongForce__receiveMessageFromNative';

  final FlutterWebviewPlugin _webViewPlugin;

  WebViewTerminalFacade(this._webViewPlugin) : assert(_webViewPlugin != null);

  @override
  void selectTerminal(TerminalData terminal) {
    _hideAndShowWhenLoaded();
    _webViewPlugin.reloadUrl(terminal.url);
  }

  @override
  void receiveContractsState(ContractsState state) {
    String contractsStateJson = state.toEncodedJson();
    _webViewPlugin.evalJavascript(
        strongForceReceiveMethodName + '(\'$contractsStateJson\');');
  }

  void _hideAndShowWhenLoaded() async {
    _webViewPlugin.hide();

    await this._webViewPlugin.onStateChanged.firstWhere(
        (WebViewStateChanged newState) =>
            newState.type == WebViewState.finishLoad);

    _webViewPlugin.show();
  }
}
