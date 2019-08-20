import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/ui/ui_bloc.dart';
import 'package:wetonomy/bloc/ui/ui_event.dart';
import 'package:wetonomy/bloc/ui/ui_state.dart';
import 'package:wetonomy/components/drawer.dart';
import 'package:wetonomy/screens/terminal/terminal_screen.dart';

class HomeScreen extends StatelessWidget {
  static const double _drawerMenuWidth = 300;
  static const int _drawerAnimationDurationMillis = 250;

  @override
  Widget build(BuildContext context) {
    final UiBloc bloc = BlocProvider.of<UiBloc>(context);

    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: _drawerMenuWidth,
            child: AppDrawer(),
          ),
          _buildTerminalScreen(bloc),
        ],
      ),
    );
  }

  Widget _buildAnimatedContent(Widget content, bool opened, UiBloc bloc) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: _drawerAnimationDurationMillis),
      curve: Curves.linearToEaseOut,
      left: opened ? _drawerMenuWidth : 0,
      top: 0,
      right: opened ? -_drawerMenuWidth : 0,
      bottom: 0,
      child: DecoratedBox(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            spreadRadius: 8,
            blurRadius: 16,
          )
        ]),
        child: Stack(
          children: <Widget>[
            content,
            opened ? _buildOverlay(bloc) : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildTerminalScreen(UiBloc bloc) {
    return BlocBuilder<UiEvent, UiState>(
      builder: (BuildContext context, UiState state) {
        return _buildAnimatedContent(
            TerminalScreen(), state.leftDrawerOpened, bloc);
      },
      bloc: bloc,
    );
  }

  Widget _buildOverlay(UiBloc bloc) {
    return InkWell(
      onTap: () => bloc.dispatch(CloseLeftDrawerUiEvent()),
      child: Container(
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
