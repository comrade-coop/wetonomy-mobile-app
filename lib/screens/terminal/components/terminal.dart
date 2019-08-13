import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/contracts_event.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/models.dart';

class Terminal extends StatefulWidget {
  final TerminalData currentTerminal;

  const Terminal({Key key, this.currentTerminal}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State(currentTerminal);
}

class _State extends State<Terminal> {
  static const String strongForceChannelName = 'StrongForceChannel';
  static const String strongForceReceiveMessage =
      'StrongForce__receiveMessageFromNative';

  TerminalData currentTerminal;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  Set<JavascriptChannel> _channels;
  ContractsBloc _contractsBloc;

  _State(this.currentTerminal);

  @override
  void initState() {
    super.initState();
    _contractsBloc = BlocProvider.of<ContractsBloc>(context);

    _contractsBloc.state.listen((ContractsState state) {
      String contractsStateJson = state.toEncodedJson();
      _sendMessageToWebView(contractsStateJson);
    });

    this._channels = [
      JavascriptChannel(
          name: strongForceChannelName,
          onMessageReceived: _onMessageReceivedFromWebView)
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: currentTerminal.url,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: this._channels,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
    );
  }

  void _onMessageReceivedFromWebView(JavascriptMessage message) {
    String extractedMsg = message.message;
    try {
      ContractAction action = ContractAction.fromJsonString(extractedMsg);
      _contractsBloc.dispatch(SendActionEvent(action));
    } on FormatException {
      _showInvalidActionSnackBar();
    }
  }

  void _sendMessageToWebView(String message) async {
    WebViewController controller = await _controller.future;
    controller
        .evaluateJavascript(strongForceReceiveMessage + '(\'$message\');');
  }

  void _showInvalidActionSnackBar() {
    final snackBar =
        SnackBar(content: Text('Terminal sent an invalid action.'));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
