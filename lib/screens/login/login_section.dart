import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_event.dart';
import 'package:wetonomy/bloc/accounts/accounts_state.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/logo_with_title_small.dart';
import 'package:wetonomy/screens/login/components/login_form.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';

class LoginSection extends StatelessWidget {
  final List<EncryptedWallet> accounts;

  const LoginSection({Key key, @required this.accounts})
      : assert(accounts != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AccountsBloc>(context);
    return BlocListener<AccountsEvent, AccountsState>(
      bloc: bloc,
      listener: (BuildContext context, AccountsState state) {
        if (state is LoggedInState) {
          Navigator.of(context).pushReplacementNamed('/terminal');
        }
      },
      child: BlocBuilder<AccountsEvent, AccountsState>(
        bloc: bloc,
        builder: (BuildContext context, AccountsState state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              LogoWithTitleSmall(),
              _buildLoginMsg(context),
              (state is ValidatingPasswordState)
                  ? CircularProgressIndicator()
                  : SizedBox(
                      height: 4,
                    ),
              (state is WrongPasswordState)
                  ? Text('The password is wrong!')
                  : SizedBox.shrink(),
              LoginForm(
                onSuccessfulValidation:
                    (EncryptedWallet wallet, String password) =>
                        bloc.dispatch(UnlockAccountEvent(wallet, password)),
                accounts: accounts,
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoginMsg(BuildContext context) {
    return Text(
      Strings.loginMsg,
      style: Theme.of(context).textTheme.subhead,
      textAlign: TextAlign.center,
    );
  }
}
