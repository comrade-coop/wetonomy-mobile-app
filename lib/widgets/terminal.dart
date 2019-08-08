import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/contracts_event.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/models.dart';

class Terminal extends StatefulWidget {
  final TerminalData _terminalData;
  final ContractsBloc _bloc;

  Terminal(this._terminalData, this._bloc)
      : assert(_terminalData != null),
        assert(_bloc != null);

  @override
  State<StatefulWidget> createState() => _TerminalState(_terminalData, _bloc);
}

class _TerminalState extends State<Terminal> {
  static const String STRONGFORCE_CHANNEL_NAME = 'StrongForceChannel';
  static const String STRONGFORCE_RECEIVE_MSG =
      'StrongForce__receiveMessageFromNative';

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final TerminalData _terminalData;
  final ContractsBloc _bloc;
  Set<JavascriptChannel> _channels;

  _TerminalState(this._terminalData, this._bloc);

  @override
  void initState() {
    super.initState();
    _bloc.state.listen(_onStateChanged);

    this._channels = Set.from([
      JavascriptChannel(
          name: STRONGFORCE_CHANNEL_NAME, onMessageReceived: _onMessageReceived)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: this._terminalData.url,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: this._channels,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
    );
  }

  void _onMessageReceived(JavascriptMessage message) {
    String extractedMsg = message.message;
    try {
      ContractAction action = ContractAction.fromJsonString(extractedMsg);
      _bloc.dispatch(SendActionEvent(this._terminalData, action));
    } on FormatException catch (e) {
      _showInvalidActionSnackBar(extractedMsg);
    }
  }

  void _onStateChanged(ContractsState newState) {
    String contractsStateJson = newState.toJson().toString();
    sendMessageToWebView(contractsStateJson);
  }

  void sendMessageToWebView(String message) async {
    WebViewController controller = await _controller.future;
    controller.evaluateJavascript(STRONGFORCE_RECEIVE_MSG + '("$message");');
  }

  void _showInvalidActionSnackBar(String message) {
    final snackBar =
        SnackBar(content: Text('Terminal sent an invalid action.'));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
