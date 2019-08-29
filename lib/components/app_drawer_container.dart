import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/components/app_drawer.dart';

class AppDrawerContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppDrawerContainerState();
}

class _AppDrawerContainerState extends State<StatefulWidget> {
  @override
  void initState() {
    super.initState();

    final TerminalsManagerBloc terminalsBloc =
        BlocProvider.of<TerminalsManagerBloc>(context);
    terminalsBloc.state.listen((TerminalsManagerState state) {
      if (state is SelectedTerminalsManagerState) {
        // If selected terminal close the drawer
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppDrawer();
  }
}
