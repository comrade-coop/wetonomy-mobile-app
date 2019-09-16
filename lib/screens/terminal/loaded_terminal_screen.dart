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

import '../../models/contract_action.dart';
import '../../models/query.dart';

class LoadedTerminalScreen extends StatefulWidget {
  static const String strongForceActionChannelName = 'StrongForceActionChannel';

  static const String strongForceQueryChannelName = 'StrongForceQueryChannel';

  @override
  _LoadedTerminalScreenState createState() => _LoadedTerminalScreenState();
}

class _LoadedTerminalScreenState extends State<LoadedTerminalScreen> {
  TerminalInteractionBloc _terminalInteractionBloc;

  Set<JavascriptChannel> _channels;
  TerminalData _currentTerminal;
  StreamSubscription<TerminalInteractionState> _terminalInteractionBlocSubscription;

  @override
  void initState() {
    super.initState();

    _terminalInteractionBloc = BlocProvider.of<TerminalInteractionBloc>(context);
    _terminalInteractionBlocSubscription =
        _terminalInteractionBloc.state.listen(_handleTerminalStateChange);

    if (_terminalInteractionBloc.currentState is ActiveTerminalInteractionState) {
      _currentTerminal =
          (_terminalInteractionBloc.currentState as ActiveTerminalInteractionState)
              ?.terminal;
    }

    this._channels = [
      JavascriptChannel(
        name: LoadedTerminalScreen.strongForceActionChannelName,
        onMessageReceived: _onActionReceivedFromWebView),
      JavascriptChannel(
        name: LoadedTerminalScreen.strongForceQueryChannelName,
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
  }

  void _handleTerminalStateChange(TerminalInteractionState state) {
    if (state is ActiveTerminalInteractionState) {
      setState(() {
        _currentTerminal = state.terminal;
      });
    }
  }

  void _onActionReceivedFromWebView(JavascriptMessage message) {
    try {
      ContractAction action = ContractAction.fromJsonString(message.message);
      _terminalInteractionBloc.dispatch(ReceiveActionFromTerminalEvent(action));
    } on FormatException {
      print('Terminal sent an invalid action:' + message.message);
    }
    
  }

  void _onQueryReceivedFromWebView(JavascriptMessage message) {
    try {
      Query query = Query.fromJsonString(message.message);
      _terminalInteractionBloc.dispatch(ReceiveQueryFromTerminalEvent(query));
    } on FormatException {
      print('Terminal sent an invalid action:' + message.message);
    }
  }
}
