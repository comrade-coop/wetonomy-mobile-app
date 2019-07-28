import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wetonomy/blocs/StrongForceBloc.dart';
import 'package:wetonomy/models/query.dart';

// TODO: Remove dummy code.
class Terminal extends StatefulWidget {
  final String _terminalUrl;
  final StrongForceBloc _bloc;

  Terminal(this._terminalUrl, this._bloc)
      : assert(_terminalUrl != null),
        assert(_bloc != null);

  @override
  State<StatefulWidget> createState() => _TerminalState(_terminalUrl, _bloc);
}

class _TerminalState extends State<Terminal> {
  static const String STRONGFORCE_CHANNEL_NAME = 'StrongForce';
  static const String STRONGFORCE_RECEIVE_MSG = 'receiveMessageFromNative';

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final String _terminalUrl;
  final StrongForceBloc _bloc;

  Set<JavascriptChannel> _channels;

  _TerminalState(this._terminalUrl, this._bloc) {
    this._channels = Set.from([_strongForceChannel(context)]);
  }

  @override
  void initState() {
    super.initState();
    _listenBlocChanges();
  }

  void _listenBlocChanges() {
    _bloc.state.listen((newState) async {
      if (newState is QueryApplied) {
        (await _controller.future)
            .evaluateJavascript(_getJavascriptSendMessage('Query success'));
      }

      if (newState is QueryLoading) {
        (await _controller.future)
            .evaluateJavascript(_getJavascriptSendMessage('Query loading...'));
      }
    });
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
        name: STRONGFORCE_CHANNEL_NAME,
        onMessageReceived: (JavascriptMessage message) {
          // TODO: Determine message type and dispatch correct event.
          _bloc.dispatch(SendQueryEvent(query: Query()));
        });
  }

  static String _getJavascriptSendMessage(String message) {
    return STRONGFORCE_RECEIVE_MSG + '("$message");';
  }
}
