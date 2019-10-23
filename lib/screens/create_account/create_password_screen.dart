import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_bloc.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_event.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_state.dart';
import 'package:wetonomy/components/slide_right_transition.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/create_password_form.dart';
import 'package:wetonomy/screens/create_account/view_mnemonic_screen.dart';

import 'components/create_account_scaffold.dart';

class CreatePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AccountSetupBloc>(context);

    return BlocListener<AccountSetupEvent, AccountSetupState>(
        bloc: bloc,
        listener: (BuildContext context, AccountSetupState state) {
          if (state is PasswordAddedState) {
            _goToMnemonicScreen(context);
          }
        },
        child: CreateAccountScaffold(
          title: Strings.createPasswordLabel,
          body: CreatePasswordForm(
            onSuccessfulValidation: (String password) {
              bloc.dispatch(AddPasswordEvent(password));
            },
          ),
        ));
  }

  void _goToMnemonicScreen(BuildContext context) {
    Navigator.push(context, slideRightTransition(ViewMnemonicScreen()));
  }
}
