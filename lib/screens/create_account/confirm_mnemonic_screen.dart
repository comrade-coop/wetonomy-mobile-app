import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_bloc.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_event.dart';
import 'package:wetonomy/components/slide_right_transition.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/accent_button.dart';
import 'package:wetonomy/screens/create_account/account_created_screen.dart';
import 'package:wetonomy/screens/create_account/components/create_account_scaffold.dart';

class ConfirmMnemonicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AccountSetupBloc>(context);

    return CreateAccountScaffold(
      title: Strings.confirmMnemonic,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('TODO'),
            AccentButton(
                label: Strings.nextLabel,
                onPressed: () {
                  bloc.dispatch(CreateAccountEvent());
                  Navigator.push(
                      context, slideRightTransition(AccountCreatedScreen()));
                })
          ],
        ),
      ),
    );
  }
}
