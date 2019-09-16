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

class LoadedTerminalScreen extends StatefulWidget {
  static const String strongForceChannelName = 'StrongForceChannel';

  @override
  _LoadedTerminalScreenState createState() => _LoadedTerminalScreenState();
}

class _LoadedTerminalScreenState extends State<LoadedTerminalScreen> {
  TerminalInteractionBloc _terminalBloc;

  Set<JavascriptChannel> _channels;
  TerminalData _currentTerminal;
  StreamSubscription<TerminalInteractionState> _terminalBlocSubscription;

  @override
  void initState() {
    super.initState();

    _terminalBloc = BlocProvider.of<TerminalInteractionBloc>(context);
    _terminalBlocSubscription =
        _terminalBloc.state.listen(_handleTerminalStateChange);

    if (_terminalBloc.currentState is ActiveTerminalInteractionState) {
      _currentTerminal =
          (_terminalBloc.currentState as ActiveTerminalInteractionState)
              ?.terminal;
    }

    this._channels = [
      JavascriptChannel(
          name: LoadedTerminalScreen.strongForceChannelName,
          onMessageReceived: _onMessageReceivedFromWebView)
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return StackDrawerWebviewScaffold(
      url: _currentTerminal?.url,
      drawer: TerminalDrawerContainer(),
      appBar: buildTerminalAppBar(context, title: _currentTerminal?.name),
      javascriptChannels: _channels,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _terminalBlocSubscription?.cancel();
  }

  void _handleTerminalStateChange(TerminalInteractionState state) {
    if (state is ActiveTerminalInteractionState) {
      setState(() {
        _currentTerminal = state.terminal;
      });
    }
  }

  void _onMessageReceivedFromWebView(JavascriptMessage message) {
    _terminalBloc
        .dispatch(ReceiveMessageTerminalInteractionEvent(message.message));
  }
}
