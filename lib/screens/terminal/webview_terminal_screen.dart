import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_bloc.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_event.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_state.dart';
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

  Set<JavascriptChannel> _channels;
  TerminalData _currentTerminal;
  StreamSubscription<TerminalInteractionState> _terminalBlocSubscription;

  final WebViewTerminalController _terminalController =
      WebViewTerminalController(FlutterWebviewPlugin());

  @override
  void initState() {
    super.initState();

    _terminalInteractionBloc =
        BlocProvider.of<TerminalInteractionBloc>(context);
    _terminalBlocSubscription =
        _terminalInteractionBloc.state.listen(_handleTerminalStateChange);

    final TerminalInteractionState currentState =
        _terminalInteractionBloc.currentState;
    if (currentState is SelectedTerminalState) {
      _currentTerminal = currentState.terminal;
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
    _terminalBlocSubscription?.cancel();
  }

  void _handleTerminalStateChange(TerminalInteractionState state) {
    if (state is SelectedTerminalState) {
      setState(() {
        _currentTerminal = state.terminal;
      });
      _terminalController.selectTerminal(state.terminal);
    } else if (state is ReceivedActionResultState) {
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
