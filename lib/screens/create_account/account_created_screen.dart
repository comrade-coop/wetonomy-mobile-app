import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_bloc.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_event.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_state.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/account_created_section.dart';
import 'package:wetonomy/screens/create_account/components/create_account_scaffold.dart';
import 'package:wetonomy/screens/create_account/loading_screen.dart';

class AccountCreatedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountSetupBloc, AccountSetupState>(
      bloc: BlocProvider.of<AccountSetupBloc>(context),
      builder: (BuildContext context, AccountSetupState state) {
        if (state is AccountSavedState) {
          return CreateAccountScaffold(
              title: Strings.congratulationsLabel,
              body: AccountCreatedSection(
                walletAddress: state.wallet.address,
              ));
        }

        return LoadingScreen(title: Strings.savingAccountLabel);
      },
    );
  }
}
