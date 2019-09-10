import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/services/terminal_facade.dart';

class WebviewTerminalFacade implements TerminalFacade {
  static const String strongForceReceiveMethodName =
      'StrongForce__receiveMessageFromNative';

  final FlutterWebviewPlugin _webviewPlugin;
  final _terminalStateStream = StreamController<TerminalLoadState>.broadcast();

  TerminalData _currentTerminal;

  WebviewTerminalFacade(this._webviewPlugin) : assert(_webviewPlugin != null) {
    _broadcastWebViewChanges();
  }

  @override
  void selectTerminal(TerminalData terminal) {
    _webviewPlugin.reloadUrl(terminal.url);
    _currentTerminal = terminal;
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

  void _broadcastWebViewChanges() {
    TerminalLoadState currentState = LoadingTerminalState(_currentTerminal);

    _webviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (state.type == WebViewState.finishLoad &&
          currentState is LoadingTerminalState) {
        currentState = LoadedTerminalState(_currentTerminal);
        _terminalStateStream.sink.add(currentState);
        FlutterWebviewPlugin().show();
      } else if (currentState is LoadedTerminalState) {
        currentState = LoadingTerminalState(_currentTerminal);
        _terminalStateStream.sink.add(currentState);
        FlutterWebviewPlugin().hide();
      }
    });
  }
}
