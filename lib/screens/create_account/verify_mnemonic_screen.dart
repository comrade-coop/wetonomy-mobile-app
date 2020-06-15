import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_bloc.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_event.dart';
import 'package:wetonomy/components/slide_right_transition.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/verify_verification_section.dart';
import 'package:wetonomy/screens/create_account/account_created_screen.dart';
import 'package:wetonomy/screens/create_account/components/create_account_scaffold.dart';

class VerifyMnemonicScreen extends StatelessWidget {
  final String mnemonic;

  const VerifyMnemonicScreen({Key key, this.mnemonic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CreateAccountScaffold(
        title: Strings.confirmMnemonic,
        body: VerifyMnemonicSection(
          onSuccessfulVerification: () {
            
            // Push and Remove all bottom views, including WelcomeScreen
            Navigator.pushAndRemoveUntil(context,
                slideRightTransition(AccountCreatedScreen()), (_) => false);
            BlocProvider.of<AccountSetupBloc>(context).add(SaveAccountEvent());
          },
          mnemonic: mnemonic,
        ));
  }
}
