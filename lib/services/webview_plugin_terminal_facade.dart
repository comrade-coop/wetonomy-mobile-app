import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/services/terminal_facade.dart';

class WebviewPluginTerminalFacade implements TerminalFacade {
  static const String strongForceReceiveMethodName =
      'StrongForce__receiveMessageFromNative';
  final FlutterWebviewPlugin _webviewPlugin = FlutterWebviewPlugin();

  @override
  void loadTerminal(TerminalData terminal) {
    _webviewPlugin.reloadUrl(terminal.url);
  }

  @override
  void receiveContractsState(ContractsState state) {
    String contractsStateJson = state.toEncodedJson();
    _webviewPlugin.evalJavascript(
        strongForceReceiveMethodName + '(\'$contractsStateJson\');');
  }
}
