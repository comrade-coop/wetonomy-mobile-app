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
    try {
      ContractAction action = ContractAction.fromJsonString(message.message);
      _bloc.dispatch(SendActionEvent(action));
    } on FormatException catch (e) {
      print('Invalid action: ${e.source}');
    }
  }

  void _onStateChanged(ContractsState state) {
    if (state is InitialContractsState) {
      sendMessageToWebView('{}');
    }

    if (state is LoadingContractsState) {
      sendMessageToWebView('{ state: \'Loading\' }');
    }

    if (state is LoadedContractsState) {
      String contractsState = state.contracts.map((c) => c.state).toString();
      sendMessageToWebView(contractsState);
    }
  }

  void sendMessageToWebView(String message) async {
    WebViewController controller = await _controller.future;
    controller.evaluateJavascript(STRONGFORCE_RECEIVE_MSG + '("$message");');
  }
}
