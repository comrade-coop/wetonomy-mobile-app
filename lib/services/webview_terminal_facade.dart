import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/services/terminal_facade.dart';

class WebViewTerminalFacade implements TerminalFacade {
  static const String strongForceReceiveMethodName =
      'StrongForce__receiveMessageFromNative';

  final FlutterWebviewPlugin _webViewPlugin;

  WebViewTerminalFacade(this._webViewPlugin) {
    this._webViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (state.type == WebViewState.finishLoad) {
        _webViewPlugin.show();
      } else {
        _webViewPlugin.hide();
      }
    });
  }

  @override
  void selectTerminal(TerminalData terminal) {
    _webViewPlugin.reloadUrl(terminal.url);
  }

  @override
  void receiveContractsState(ContractsState state) {
    String contractsStateJson = state.toEncodedJson();
    _webViewPlugin.evalJavascript(
        strongForceReceiveMethodName + '(\'$contractsStateJson\');');
  }
}
