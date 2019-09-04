import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/screens/terminal/components/terminal_drawer.dart';

class TerminalDrawerContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TerminalsManagerEvent, TerminalsManagerState>(
      bloc: BlocProvider.of<TerminalsManagerBloc>(context),
      listener: (BuildContext context, TerminalsManagerState state) {
        if (state is SelectedTerminalState) {
          // If selected terminal close the drawer
          Navigator.of(context).pop();
        }

        if (state is AddedTerminalState) {
          // If added terminal close the drawer to open the new terminal
          Navigator.of(context).pop();
        }
      },
      child: AppDrawer(),
    );
  }
}
