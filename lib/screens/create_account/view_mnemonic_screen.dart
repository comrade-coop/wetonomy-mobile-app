import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_bloc.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_event.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_state.dart';
import 'package:wetonomy/components/slide_right_transition.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/view_mnemonic_section.dart';
import 'package:wetonomy/screens/create_account/components/create_account_scaffold.dart';
import 'package:wetonomy/screens/create_account/loading_screen.dart';

import 'verify_mnemonic_screen.dart';

class ViewMnemonicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    

    return BlocBuilder<AccountSetupBloc, AccountSetupState>(
      builder: (BuildContext context, AccountSetupState state) {
        if (state is MnemonicCreatedState) {
          return CreateAccountScaffold(
            title: Strings.secretPhraseLabel,
            body: ViewMnemonicSection(
              mnemonic: state.mnemonic,
              onNextPressed: () => Navigator.push(
                  context,
                  slideRightTransition(VerifyMnemonicScreen(
                    mnemonic: state.mnemonic,
                  ))),
            ),
          );
        }

        if (state is PasswordAddedState) {
          BlocProvider.of<AccountSetupBloc>(context).add(CreateMnemonicEvent());
        }

        return LoadingScreen(title: Strings.creatingMnemonicLabel);
      },
    );
  }
}
