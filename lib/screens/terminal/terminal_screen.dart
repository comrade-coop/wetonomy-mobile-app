import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/contracts/contracts_bloc.dart';
import 'package:wetonomy/bloc/contracts/contracts_event.dart';
import 'package:wetonomy/bloc/contracts/contracts_state.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_state.dart';
import 'package:wetonomy/components/account_avatar.dart';
import 'package:wetonomy/components/app_drawer_container.dart';
import 'package:wetonomy/components/terminals/empty_terminals_section.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/screens/terminal/loading_terminals_section.dart';

class TerminalScreen extends StatefulWidget {
  static const String strongForceChannelName = 'StrongForceChannel';
  static const String strongForceReceiveMessage =
      'StrongForce__receiveMessageFromNative';

  @override
  State<StatefulWidget> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  TerminalsManagerBloc _terminalsBloc;
  Set<JavascriptChannel> _channels;
  TerminalsManagerState _currentState;
  ContractsBloc _contractsBloc;
  final FlutterWebviewPlugin _webViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    _terminalsBloc = BlocProvider.of<TerminalsManagerBloc>(context);
    _terminalsBloc.state.listen(_handleTerminalManagerStateChange);

    _contractsBloc = BlocProvider.of<ContractsBloc>(context);
    _contractsBloc.state.listen((ContractsState state) {
      String contractsStateJson = state.toEncodedJson();
      _sendMessageToWebView(contractsStateJson);
    });

    this._channels = [
      JavascriptChannel(
          name: TerminalScreen.strongForceChannelName,
          onMessageReceived: _onMessageReceivedFromWebView)
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentState is InitialTerminalsManagerState ||
        _currentState is LoadingTerminalsManagerState) {
      return LoadingTerminalsSection();
    }

    if (_currentState is EmptyTerminalsManagerState) {
      return EmptyTerminalsSection();
    }

    TerminalData currentTerminal =
        (_currentState as LoadedTerminalsManagerState).currentTerminal;

    return StackDrawerWebviewScaffold(
      url: currentTerminal.url,
      drawer: AppDrawerContainer(),
      appBar: AppBar(
        title: Text(
          currentTerminal.url,
          maxLines: 1,
        ),
        actions: <Widget>[
          _buildSearch(),
          AccountAvatar(),
        ],
      ),
      javascriptChannels: _channels,
    );
  }

  void _handleTerminalManagerStateChange(TerminalsManagerState state) {
    if (state is LoadedTerminalsManagerState) {
      _webViewPlugin.reloadUrl(state.currentTerminal.url);
    }

    setState(() {
      _currentState = state;
    });
  }

  Widget _buildSearch() {
    // TODO: Implement terminal search
    return IconButton(icon: Icon(Icons.search), onPressed: null);
  }

  void _onMessageReceivedFromWebView(JavascriptMessage message) {
    String actionMsg = message.message;
    try {
      ContractAction action = ContractAction.fromJsonString(actionMsg);
      _contractsBloc.dispatch(SendActionEvent(action));
    } on FormatException {
      print('Terminal sent an invalid action:' + actionMsg);
    }
  }

  void _sendMessageToWebView(String message) {
    _webViewPlugin.evalJavascript(
        TerminalScreen.strongForceReceiveMessage + '(\'$message\');');
  }
}
