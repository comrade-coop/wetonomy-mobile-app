import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/screens/loading_terminal/loading_terminals_screen.dart';
import 'package:wetonomy/screens/terminal/components/terminal_drawer_container.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/screens/terminal/components/terminal_app_bar.dart';

//class LoadedTerminalScreen extends StatefulWidget {
//  static const String strongForceChannelName = 'StrongForceChannel';
//
//  const LoadedTerminalScreen(this.initialTerminal);
//
//  final TerminalData initialTerminal;
//
//  @override
//  _LoadedTerminalScreenState createState() => _LoadedTerminalScreenState();
//}
//
//class _LoadedTerminalScreenState extends State<LoadedTerminalScreen> {
//  TerminalInteractionBloc _bloc;
//
//  Set<JavascriptChannel> _channels;
//  TerminalData _currentTerminal;
//  StreamSubscription<TerminalInteractionState> _blocStateSubscription;
//
//  @override
//  void initState() {
//    super.initState();
//
//    _currentTerminal = widget.initialTerminal;
//
//    _bloc = BlocProvider.of<TerminalInteractionBloc>(context);
//    _blocStateSubscription = _bloc.state.listen(_handleTerminalStateChange);
//
//    this._channels = [
//      JavascriptChannel(
//          name: LoadedTerminalScreen.strongForceChannelName,
//          onMessageReceived: _onMessageReceivedFromWebView)
//    ].toSet();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return StackDrawerWebviewScaffold(
//      url: widget.initialTerminal.url,
//      drawer: TerminalDrawerContainer(),
//      appBar: buildTerminalAppBar(terminal: _currentTerminal),
//      javascriptChannels: _channels,
//    );
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _blocStateSubscription?.cancel();
//  }
//
//  void _handleTerminalStateChange(TerminalInteractionState state) {
//    if (state is LoadedTerminalInteractionState) {
//      setState(() {
//        _currentTerminal = state.terminal;
//      });
//    } else if (state is LoadingTerminalInteractionState) {
//      setState(() {
//        _loading
//      })
//    }
//  }
//
//  void _onMessageReceivedFromWebView(JavascriptMessage message) {
//    _bloc.dispatch(ReceiveMessageFromTerminalEvent(message.message));
//  }
//}

class LoadedTerminalScreen extends StatelessWidget {
  static const String strongForceChannelName = 'StrongForceChannel';

  const LoadedTerminalScreen(this.initialTerminal);

  final TerminalData initialTerminal;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TerminalInteractionBloc>(context);
    Set<JavascriptChannel> _channels = [
      JavascriptChannel(
          name: LoadedTerminalScreen.strongForceChannelName,
          onMessageReceived: (JavascriptMessage message) =>
              bloc.dispatch(ReceiveMessageFromTerminalEvent(message.message)))
    ].toSet();

    return BlocBuilder<TerminalInteractionEvent, TerminalInteractionState>(
      builder: (BuildContext context, TerminalInteractionState state) {
        if (state is LoadingTerminalInteractionState) {
          return StackDrawerWebviewScaffold(
            url: state.terminal.url,
            drawer: TerminalDrawerContainer(),
            appBar: buildTerminalAppBar(terminal: state.terminal),
            javascriptChannels: _channels,
          );
        }

        if (state is LoadedTerminalInteractionState) {
          return StackDrawerWebviewScaffold(
            url: state.terminal.url,
            drawer: TerminalDrawerContainer(),
            appBar: buildTerminalAppBar(terminal: state.terminal),
            javascriptChannels: _channels,
          );
        }

        return StackDrawerWebviewScaffold(
          url: initialTerminal.url,
          drawer: TerminalDrawerContainer(),
          appBar: buildTerminalAppBar(terminal: initialTerminal),
          javascriptChannels: _channels,
        );
      },
      bloc: bloc,
    );
  }
}
