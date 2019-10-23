import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_event.dart';
import 'package:wetonomy/bloc/accounts/accounts_state.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/loading_screen.dart';
import 'package:wetonomy/screens/login/login_section.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AccountsBloc>(context);
    return BlocBuilder<AccountsEvent, AccountsState>(
      bloc: bloc,
      builder: (BuildContext context, AccountsState state) {
        if (state is AccountsFetchedState) {
          return LoginSection(wallets: state.accounts);
        }

        bloc.dispatch(LoadAccountsEvent());
        return LoadingScreen(
          title: Strings.loadingAccountsLabel,
        );
      },
    );
  }
}
