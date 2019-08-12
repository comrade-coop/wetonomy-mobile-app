import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/terminals_bloc.dart';
import 'package:wetonomy/bloc/terminals_event.dart';
import 'package:wetonomy/bloc/terminals_state.dart';
import 'package:wetonomy/screens/terminal/components/terminals_section.dart';

class TerminalsSectionContainer extends StatefulWidget {
  @override
  _TerminalsSectionContainerState createState() =>
      _TerminalsSectionContainerState();
}

class _TerminalsSectionContainerState extends State<TerminalsSectionContainer> {
  TerminalsBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<TerminalsBloc>(context);
    _bloc.dispatch(LoadTerminalsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TerminalsEvent, TerminalsState>(
      builder: (context, state) {
        if (state is LoadedTerminalState) {
          return TerminalsSection(
              terminals: state.terminals,
              onTerminalSelected: _handleTerminalSelected,
              selectedTerminalIndex: state.selectedTerminalIndex);
        }

        return Text('Loading terminals...');
      },
      bloc: _bloc,
    );
  }

  void _handleTerminalSelected(int index) {
    _bloc.dispatch(SelectTerminalEvent(index));
  }
}
