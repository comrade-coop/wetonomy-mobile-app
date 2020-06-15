import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_state.dart';
import 'package:wetonomy/components/transparent_status_bar.dart';
import 'package:wetonomy/screens/empty_terminals/empty_terminals_screen.dart';
import 'package:wetonomy/screens/loading_terminal/loading_terminals_screen.dart';
import 'package:wetonomy/screens/terminal/webview_terminal_screen.dart';

import '../../routes.dart';

class TerminalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransparentStatusBar(
      child: BlocBuilder<TerminalsManagerBloc, TerminalsManagerState>(
        builder: (BuildContext context, TerminalsManagerState state) {
          if (state is InitialTerminalsManagerState) {
            BlocProvider.of<TerminalsManagerBloc>(context)
                .add(LoadTerminalsManagerEvent());
            return LoadingTerminalsScreen();
          }

          if (state is LoadingTerminalsManagerState) {
            return LoadingTerminalsScreen();
          }

          if (state is EmptyTerminalsManagerState) {
            return EmptyTerminalsScreen();
          }

          if (state is LoadedTerminalsManagerState) {
            if (state.currentTerminal.nativeTerminal) {
              if (nativeTerminals.containsKey(state.currentTerminal.url))
                return nativeTerminals[state.currentTerminal.url];
            } else
              return WebViewTerminalScreen();
          }

          return EmptyTerminalsScreen();
        },
      ),
    );
  }
}
