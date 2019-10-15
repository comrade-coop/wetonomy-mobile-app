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

import 'confirm_mnemonic_screen.dart';

class ViewMnemonicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AccountSetupBloc>(context);

    return BlocBuilder<AccountSetupEvent, AccountSetupState>(
      bloc: bloc,
      builder: (BuildContext context, AccountSetupState state) {
        if (state is MnemonicCreatedState) {
          return CreateAccountScaffold(
            title: Strings.secretPhraseLabel,
            body: ViewMnemonicSection(
              mnemonic: state.mnemonic,
              onNextPressed: () => Navigator.push(
                  context,
                  slideRightTransition(ConfirmMnemonicScreen(
                    mnemonic: state.mnemonic,
                  ))),
            ),
          );
        }

        bloc.dispatch(CreateMnemonicEvent());
        return LoadingScreen(title: Strings.creatingMnemonicLabel);
      },
    );
  }
}
