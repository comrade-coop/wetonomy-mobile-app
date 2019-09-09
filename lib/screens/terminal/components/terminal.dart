import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/contracts/contracts_event.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/models.dart';

class Terminal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  static const String strongForceChannelName = 'StrongForceChannel';
  static const String strongForceReceiveMessage =
      'StrongForce__receiveMessageFromNative';

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  TerminalsManagerBloc _terminalsBloc;
  Set<JavascriptChannel> _channels;
  ContractsBloc _contractsBloc;

  StreamSubscription<ContractsState> _contractsBlocSubscription;
  StreamSubscription<TerminalsManagerState> _terminalsBlocSubscription;

  @override
  void initState() {
    super.initState();

    _contractsBloc = BlocProvider.of<ContractsBloc>(context);
    _terminalsBloc = BlocProvider.of<TerminalsManagerBloc>(context);

    _contractsBlocSubscription =
        _contractsBloc.state.listen((ContractsState state) {
      String contractsStateJson = state.toEncodedJson();
      _sendMessageToWebView(contractsStateJson);
    });

    _terminalsBlocSubscription =
        _terminalsBloc.state.listen((TerminalsManagerState state) async {
      if (state is LoadedTerminalsState) {
        print(state.currentTerminal.url);
        WebViewController controller = await _controller.future;
        setState(() {
          print(state.currentTerminal.url);
          controller.loadUrl(state.currentTerminal.url);
        });
      }
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
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: this._channels,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _contractsBlocSubscription?.cancel();
    _terminalsBlocSubscription?.cancel();
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
