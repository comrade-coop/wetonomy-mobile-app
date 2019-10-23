import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_event.dart';
import 'package:wetonomy/bloc/accounts/accounts_state.dart';
import 'package:wetonomy/screens/login/components/password_form.dart';
import 'package:wetonomy/screens/welcome/components/logo_with_title.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';

class LoginSection extends StatefulWidget {
  final List<EncryptedWallet> wallets;

  const LoginSection({Key key, @required this.wallets})
      : assert(wallets != null),
        super(key: key);

  @override
  _LoginSectionState createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  AccountsBloc bloc;

  StreamSubscription<AccountsState> _subscription;

  String _error;

  @override
  void initState() {
    super.initState();

    bloc = BlocProvider.of<AccountsBloc>(context);
    _subscription = bloc.state.listen((AccountsState state) {
      if (state is LoggedInState) {
        Navigator.of(context).pushReplacementNamed('/terminal');
      } else if (state is WrongPasswordState) {
        _error = 'Wrong Password!';
      } else if (state is ValidatingPasswordState) {
        // Show loading...
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      padding: EdgeInsets.all(16),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[LogoWithTitle(), PasswordForm()],
        ),
      ),
    ));
  }

  void _tryUnlockAccount(EncryptedWallet wallet, String password) {
    bloc.dispatch(UnlockAccountEvent(wallet, password));
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
