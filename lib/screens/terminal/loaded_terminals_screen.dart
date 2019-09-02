import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_state.dart';
import 'package:wetonomy/screens/terminal/terminal_drawer_container.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/screens/terminal/components/terminal_app_bar.dart';
import 'package:wetonomy/services/service_locator.dart';

class LoadedTerminalScreen extends StatefulWidget {
  static const String strongForceChannelName = 'StrongForceChannel';
  static const String strongForceReceiveMessage =
      'StrongForce__receiveMessageFromNative';

  const LoadedTerminalScreen(this.initialTerminal);

  final TerminalData initialTerminal;

  @override
  _LoadedTerminalScreenState createState() => _LoadedTerminalScreenState();
}

class _LoadedTerminalScreenState extends State<LoadedTerminalScreen> {
  final FlutterWebviewPlugin _webViewPlugin =
      locator.get<FlutterWebviewPlugin>();
  TerminalsManagerBloc _terminalsBloc;

  Set<JavascriptChannel> _channels;
  TerminalData _currentTerminal;

  @override
  void initState() {
    super.initState();

    _currentTerminal = widget.initialTerminal;

    _terminalsBloc = BlocProvider.of<TerminalsManagerBloc>(context);
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

  void _handleTerminalManagerStateChange(TerminalsManagerState state) {
    if (state is LoadedTerminalsManagerState) {
      setState(() {
        _currentTerminal = state.currentTerminal;
      });
      _webViewPlugin.reloadUrl(_currentTerminal.url);
    }
  }

  void _onMessageReceivedFromWebView(JavascriptMessage message) {
    _terminalsBloc.dispatch(ReceiveMessageFromTerminalEvent(message.message));
  }
}
