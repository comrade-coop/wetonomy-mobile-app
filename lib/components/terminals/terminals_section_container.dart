import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager_event.dart';
import 'package:wetonomy/bloc/terminals_manager_state.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/components/terminals/terminals_section.dart';

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
              onTerminalSelected: (TerminalData terminal) {
                if (terminal != state.currentTerminal) {
                  bloc.dispatch(SelectTerminalEvent(terminal));
                  Navigator.of(context).pop();
                }
              },
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
      bloc: bloc,
    );
  }
}
