import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager_event.dart';
import 'package:wetonomy/bloc/terminals_manager_state.dart';
import 'package:wetonomy/components/account_avatar.dart';
import 'package:wetonomy/components/drawer.dart';
import 'package:wetonomy/components/terminals/empty_terminals_section.dart';
import 'package:wetonomy/screens/terminal/components/terminal.dart';
import 'package:wetonomy/screens/terminal/loading_terminals_section.dart';

class TerminalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TerminalsManagerBloc bloc =
        BlocProvider.of<TerminalsManagerBloc>(context);

    return BlocBuilder<TerminalsManagerEvent, TerminalsManagerState>(
      builder: (BuildContext context, TerminalsManagerState state) {
        return Scaffold(
          appBar: _buildAppBar(state),
          body: _buildBody(state),
          drawer: AppDrawer(),
        );
      },
      bloc: bloc,
    );
  }

  AppBar _buildAppBar(TerminalsManagerState state) {
    String title = '';
    if (state is LoadedTerminalsManagerState) {
      title = state.currentTerminal.url;
    }

    return AppBar(title: Text(title), elevation: 1, actions: <Widget>[
      IconButton(icon: Icon(Icons.search), onPressed: null),
      AccountAvatar(),
    ]);
  }

  Widget _buildBody(TerminalsManagerState state) {
    if (state is InitialTerminalsManagerState ||
        state is LoadingTerminalsManagerState) {
      return LoadingTerminalsSection();
    }

    if (state is EmptyTerminalsManagerState) {
      return EmptyTerminalsSection();
    }

    return Terminal();
  }
}
