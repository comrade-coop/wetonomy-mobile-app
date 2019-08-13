import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager_event.dart';
import 'package:wetonomy/bloc/terminals_manager_state.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/screens/terminal/components/terminals_section.dart';

class TerminalsListSectionContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TerminalsManagerBloc bloc =
        BlocProvider.of<TerminalsManagerBloc>(context);

    return BlocBuilder<TerminalsManagerEvent, TerminalsManagerState>(
      builder: (context, state) {
        if (state is LoadedTerminalsManagerState) {
          return TerminalsListSection(
              terminals: state.terminals,
              onTerminalSelected: (TerminalData terminal) =>
                  bloc.dispatch(SelectTerminalEvent(terminal)),
              selectedTerminalIndex:
                  state.terminals.indexOf(state.currentTerminal));
        }

        if (state is InitialTerminalsManagerState) {
          bloc.dispatch(LoadTerminalsEvent());
          return Text('Loading terminals...');
        }

        if (state is LoadingTerminalsManagerState) {
          return Text('Loading terminals...');
        }

        return TerminalsListSection(
          terminals: [],
        );
      },
      bloc: bloc,
    );
  }
}
