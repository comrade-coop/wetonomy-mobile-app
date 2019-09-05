import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/services/terminal_facade.dart';

class WebviewTerminalFacade implements TerminalFacade {
  static const String strongForceReceiveMethodName =
      'StrongForce__receiveMessageFromNative';

  final FlutterWebviewPlugin _webviewPlugin;
  final _terminalStateStream =
      StreamController<TerminalLoadState>.broadcast();

  WebviewTerminalFacade(this._webviewPlugin) : assert(_webviewPlugin != null) {
    _webviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (state.type == WebViewState.finishLoad) {
        _terminalStateStream.add(TerminalLoadState.Loaded);
      }

      _terminalStateStream.add(TerminalLoadState.Loading);
    });
  }

  @override
  void selectTerminal(TerminalData terminal) {
    _webviewPlugin.reloadUrl(terminal.url);
  }

  @override
  void receiveContractsState(ContractsState state) {
    String contractsStateJson = state.toEncodedJson();
    _webviewPlugin.evalJavascript(
        strongForceReceiveMethodName + '(\'$contractsStateJson\');');
  }

  @override
  Stream<TerminalLoadState> get onTerminalLoadStateChanged =>
      _terminalStateStream.stream;
}
