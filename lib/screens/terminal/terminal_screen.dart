import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_state.dart';
import 'package:wetonomy/bloc/ui/ui_bloc.dart';
import 'package:wetonomy/bloc/ui/ui_event.dart';
import 'package:wetonomy/bloc/ui/ui_state.dart';
import 'package:wetonomy/components/account_avatar.dart';
import 'package:wetonomy/components/terminals/empty_terminals_section.dart';
import 'package:wetonomy/screens/terminal/components/terminal.dart';
import 'package:wetonomy/screens/terminal/loading_terminals_section.dart';

class TerminalScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  TerminalsManagerBloc _terminalsBloc;
  UiBloc _uiBloc;
  String _title = '';

  TerminalsManagerState _currentState;

  _TerminalScreenState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  }

  @override
  void initState() {
    super.initState();

    _terminalsBloc = BlocProvider.of<TerminalsManagerBloc>(context);
    _uiBloc = BlocProvider.of<UiBloc>(context);

    _terminalsBloc.state.listen(_handleTerminalManagerStateChange);

    _uiBloc.state.listen(_handleUiStateChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        title: Text(_title),
        elevation: 1,
        leading: _buildMenuIcon(),
        actions: <Widget>[
          _buildSearch(),
          AccountAvatar(),
        ]);
  }

  Widget _buildBody() {
    if (_currentState is InitialTerminalsManagerState ||
        _currentState is LoadingTerminalsManagerState) {
      return LoadingTerminalsSection();
    }

    if (_currentState is EmptyTerminalsManagerState) {
      return EmptyTerminalsSection();
    }

    return Terminal();
  }

  void _handleTerminalManagerStateChange(TerminalsManagerState state) {
    if (state is LoadedTerminalsManagerState) {
      setState(() {
        _title = state.currentTerminal.url;
      });
    }

    setState(() {
      _currentState = state;
    });
  }

  void _handleUiStateChange(UiState state) {
    setState(() {
      if (state.leftDrawerOpened) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  _buildMenuIcon() {
    return IconButton(
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: _controller),
      onPressed: () {
        _uiBloc.dispatch(OpenLeftDrawerUiEvent());
      },
    );
  }

  Widget _buildSearch() {
    // TODO: Implement terminal search
    return IconButton(icon: Icon(Icons.search), onPressed: null);
  }
}
