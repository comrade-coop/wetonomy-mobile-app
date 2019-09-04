import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_state.dart';
import 'package:wetonomy/screens/terminal/components/empty_terminals_screen.dart';
import 'package:wetonomy/components/transparent_status_bar.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/screens/terminal/loaded_terminals_screen.dart';
import 'package:wetonomy/screens/terminal/loading_terminals_section.dart';

class TerminalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransparentStatusBar(
      child: BlocBuilder<TerminalsManagerEvent, TerminalsManagerState>(
        builder: (BuildContext context, TerminalsManagerState state) {
          if (state is InitialTerminalsManagerState ||
              state is LoadingTerminalsManagerState) {
            return LoadingTerminalsScreen();
          }

          if (state is EmptyTerminalsManagerState) {
            return EmptyTerminalsScreen();
          }

          TerminalData currentTerminal =
              (state as LoadedTerminalsState).currentTerminal;
          return LoadedTerminalScreen(currentTerminal);
        },
        bloc: BlocProvider.of<TerminalsManagerBloc>(context),
      ),
    );
  }
}
