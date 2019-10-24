import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_state.dart';
import 'package:wetonomy/screens/login/login_section.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AccountsBloc>(context);
    if (!(bloc.currentState is AccountsFetchedState)) {
      throw StateError('Login screen expects accounts to exist!');
    }

    final accounts = (bloc.currentState as AccountsFetchedState).accounts;

    return Material(
        child: Container(
            padding: EdgeInsets.all(32),
            child: SafeArea(
              child: LoginSection(
                accounts: accounts,
              ),
            )));
  }
}
