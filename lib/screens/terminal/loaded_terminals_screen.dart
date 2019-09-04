import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_state.dart';
import 'package:wetonomy/screens/terminal/terminal_drawer_container.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/screens/terminal/components/terminal_app_bar.dart';

class LoadedTerminalScreen extends StatefulWidget {
  static const String strongForceChannelName = 'StrongForceChannel';

  const LoadedTerminalScreen(this.initialTerminal);

  final TerminalData initialTerminal;

  @override
  _LoadedTerminalScreenState createState() => _LoadedTerminalScreenState();
}

class _LoadedTerminalScreenState extends State<LoadedTerminalScreen> {
  TerminalsManagerBloc _terminalsBloc;

  Set<JavascriptChannel> _channels;
  TerminalData _currentTerminal;
  StreamSubscription<TerminalsManagerState> _terminalsBlocSubscription;

  @override
  void initState() {
    super.initState();

    _currentTerminal = widget.initialTerminal;

    _terminalsBloc = BlocProvider.of<TerminalsManagerBloc>(context);
    _terminalsBlocSubscription =
        _terminalsBloc.state.listen(_handleTerminalManagerStateChange);

    this._channels = [
      JavascriptChannel(
          name: LoadedTerminalScreen.strongForceChannelName,
          onMessageReceived: _onMessageReceivedFromWebView)
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return StackDrawerWebviewScaffold(
      url: widget.initialTerminal.url,
      drawer: TerminalDrawerContainer(),
      appBar: buildTerminalAppBar(terminal: _currentTerminal),
      javascriptChannels: _channels,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _terminalsBlocSubscription?.cancel();
  }

  void _handleTerminalManagerStateChange(TerminalsManagerState state) {
    if (state is LoadedTerminalsState) {
      setState(() {
        _currentTerminal = state.currentTerminal;
      });
    }
  }

  void _onMessageReceivedFromWebView(JavascriptMessage message) {
    _terminalsBloc.dispatch(ReceiveMessageFromTerminalEvent(message.message));
  }
}
