import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager_event.dart';
import 'package:wetonomy/bloc/terminals_manager_state.dart';
import 'package:wetonomy/screens/terminal/components/drawer.dart';
import 'package:wetonomy/screens/terminal/components/terminal.dart';

class TerminalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TerminalsManagerBloc bloc =
        BlocProvider.of<TerminalsManagerBloc>(context);

    return BlocBuilder<TerminalsManagerEvent, TerminalsManagerState>(
      builder: (BuildContext context, TerminalsManagerState state) {
        if (state is LoadedTerminalsManagerState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.currentTerminal.url),
              elevation: 1,
              actions: <Widget>[
                _buildSearchButton(),
                _buildProfileAvatar(),
              ],
            ),
            body: Terminal(
              currentTerminal: state.currentTerminal,
            ),
            drawer: AppDrawer(),
          );
        }

        if (state is InitialTerminalsManagerState) {
          bloc.dispatch(LoadTerminalsEvent());
          return Scaffold(
            appBar: AppBar(
              title: Text('Wetonomy'),
              elevation: 1,
            ),
            body: Center(child: CircularProgressIndicator()),
            drawer: AppDrawer(),
          );
        }

        if (state is LoadingTerminalsManagerState) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Wetonomy'),
              elevation: 1,
            ),
            body: Center(child: CircularProgressIndicator()),
            drawer: AppDrawer(),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Wetonomy'),
            elevation: 1,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Looks like you don\'t have any terminals installed currently.\n\n Press the button below to add one.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              )),
              SizedBox(
                height: 16.0,
              ),
              FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.add,
                  size: 32,
                ),
              )
            ],
          ),
          drawer: AppDrawer(),
        );
      },
      bloc: bloc,
    );
  }

  Widget _buildProfileAvatar() => Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 8.0),
        child: CircleAvatar(
          backgroundColor: Colors.grey.withAlpha(50),
          child: Icon(
            Icons.person,
            size: 32,
            color: Colors.grey,
          ),
        ),
      );

  Widget _buildSearchButton() =>
      IconButton(icon: Icon(Icons.search), onPressed: null);
}
