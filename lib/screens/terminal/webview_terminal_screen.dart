import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/screens/terminal/components/terminal_drawer_container.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/screens/terminal/components/terminal_app_bar.dart';
import 'package:wetonomy/services/webview_terminal_controller.dart';

class WebViewTerminalScreen extends StatefulWidget {
  @override
  _WebViewTerminalScreenState createState() => _WebViewTerminalScreenState();
}

class _WebViewTerminalScreenState extends State<WebViewTerminalScreen> {
  static const String strongForceActionChannelName = 'StrongForceActionChannel';
  static const String strongForceQueryChannelName = 'StrongForceQueryChannel';

  TerminalInteractionBloc _terminalInteractionBloc;
  TerminalsManagerBloc _terminalManagerBloc;

  Set<JavascriptChannel> _channels;
  TerminalData _currentTerminal;
  StreamSubscription<TerminalInteractionState>
      _terminalInteractionBlocSubscription;
  StreamSubscription<TerminalsManagerState> _terminalsManagerBlocSubscription;

  final WebViewTerminalController _terminalController =
      WebViewTerminalController(FlutterWebviewPlugin());

  @override
  void initState() {
    super.initState();

    _terminalInteractionBloc =
        BlocProvider.of<TerminalInteractionBloc>(context);

    _terminalManagerBloc = BlocProvider.of<TerminalsManagerBloc>(context);

    _terminalInteractionBlocSubscription =
        _terminalInteractionBloc.state.listen(_handleTerminalStateChange);

    _terminalsManagerBlocSubscription =
        _terminalManagerBloc.state.listen(_handlleTerminalsManagerStateChange);

    final TerminalsManagerState currentState =
        _terminalManagerBloc.currentState;
    if (currentState is SelectedTerminalsManagerState) {
      _currentTerminal = currentState.currentTerminal;
    }

    this._channels = [
      JavascriptChannel(
          name: strongForceActionChannelName,
          onMessageReceived: _onActionReceivedFromWebView),
      JavascriptChannel(
          name: strongForceQueryChannelName,
          onMessageReceived: _onQueryReceivedFromWebView)
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return StackDrawerWebviewScaffold(
      url: _currentTerminal?.url,
      drawer: TerminalDrawerContainer(),
      appBar: buildTerminalAppBar(terminal: _currentTerminal),
      javascriptChannels: _channels,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _terminalInteractionBlocSubscription?.cancel();
    _terminalsManagerBlocSubscription?.cancel();
  }

  void _handlleTerminalsManagerStateChange(TerminalsManagerState state) {
    if (state is SelectedTerminalsManagerState) {
      _terminalController.selectTerminal(state.currentTerminal);
      setState(() {
        _currentTerminal = state.currentTerminal;
      });
    }
  }

  void _handleTerminalStateChange(TerminalInteractionState state) {
    if (state is ReceivedActionResultState) {
      _terminalController.handleActionResult(state.result);
    } else if (state is ReceivedQueryResultState) {
      _terminalController.handleQueryResult(state.result);
    } else if (state is ContractStateChangedState) {
      _terminalController.handleContractsStateChange(state.contract);
    }
  }

  void _onActionReceivedFromWebView(JavascriptMessage message) {
    _terminalInteractionBloc
        .dispatch(ReceiveActionFromTerminalEvent(message.message));
  }

  void _onQueryReceivedFromWebView(JavascriptMessage message) {
    _terminalInteractionBloc
        .dispatch(ReceiveQueryFromTerminalEvent(message.message));
  }
}
