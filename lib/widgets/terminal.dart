import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/contracts_event.dart';
import 'package:wetonomy/models/contract_action.dart';

class Terminal extends StatefulWidget {
  final String _url;
  final ContractsBloc _bloc;

  Terminal(this._url, this._bloc)
      : assert(_url != null),
        assert(_bloc != null);

  @override
  State<StatefulWidget> createState() => _TerminalState(_url, _bloc);
}

class _TerminalState extends State<Terminal> {
  static const String STRONGFORCE_CHANNEL_NAME = 'StrongForce';
  static const String STRONGFORCE_RECEIVE_MSG = 'receiveMessageFromNative';

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final String _terminalUrl;
  final ContractsBloc _bloc;

  Set<JavascriptChannel> _channels;

  _TerminalState(this._terminalUrl, this._bloc) {
    this._channels = Set.from([_strongForceChannel(context)]);
  }

  @override
  void initState() {
    super.initState();
    _bloc.state.listen(_onStateChanged);
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: this._terminalUrl,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: this._channels,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
    );
  }

  JavascriptChannel _strongForceChannel(BuildContext context) {
    return JavascriptChannel(
        name: STRONGFORCE_CHANNEL_NAME, onMessageReceived: _onMessageReceived);
  }

  void _onMessageReceived(JavascriptMessage message) {
    Map<String, dynamic> actionJson = jsonDecode(message.message);
    ContractAction action = ContractAction.fromJson(actionJson);

    _bloc.dispatch(SendActionEvent(action));
  }

  void _onStateChanged(ContractsState state) async {
    if (state is LoadingContractsState) {
      (await _controller.future)
          .evaluateJavascript(_getJavascriptSendMessage('Action loading...'));
    }

    if (state is LoadedContractsState) {
      (await _controller.future)
          .evaluateJavascript(_getJavascriptSendMessage('Action applied!'));
    }
  }

  static String _getJavascriptSendMessage(String message) {
    return STRONGFORCE_RECEIVE_MSG + '("$message");';
  }
}
