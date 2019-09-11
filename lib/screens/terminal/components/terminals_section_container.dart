import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_event.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_state.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/screens/terminal/components/terminals_section.dart';

class TerminalsListSectionContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TerminalsManagerBloc terminalsBloc =
        BlocProvider.of<TerminalsManagerBloc>(context);

    return BlocBuilder<TerminalsManagerEvent, TerminalsManagerState>(
      builder: (context, state) {
        if (state is LoadedTerminalsManagerState) {
          return TerminalsListSection(
              terminals: state.terminals,
              onTerminalSelected: (TerminalData terminal) =>
                  _handleTerminalSelected(terminal, terminalsBloc),
              onTerminalRemoved: (TerminalData terminal) =>
                  _handleTerminalRemoved(terminal, terminalsBloc),
              selectedTerminalIndex:
                  state.terminals.indexOf(state.currentTerminal));
        }

        if (state is InitialTerminalsManagerState ||
            state is LoadingTerminalsManagerState) {
          return Center(child: CircularProgressIndicator());
        }

        return TerminalsListSection(
          terminals: [],
        );
      },
      bloc: terminalsBloc,
    );
  }

  void _handleTerminalSelected(
      TerminalData terminal, TerminalsManagerBloc terminalsBloc) {
    terminalsBloc.dispatch(SelectTerminalsManagerEvent(terminal));
  }

  _handleTerminalRemoved(
      TerminalData terminal, TerminalsManagerBloc terminalsBloc) {
    terminalsBloc.dispatch(RemoveTerminalsManagerEvent(terminal));
  }
}
