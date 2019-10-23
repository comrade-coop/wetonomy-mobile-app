import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_event.dart';
import 'package:wetonomy/bloc/accounts/accounts_state.dart';
import 'package:wetonomy/screens/welcome/components/welcome_section.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AccountsBloc>(context);
    bloc.dispatch(LoadAccountsEvent());

    return BlocListener(
        bloc: bloc,
        listener: (BuildContext context, AccountsState state) {
          if (state is AccountsFetchedState) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        },
        child: WelcomeSection()
    );
  }
}
