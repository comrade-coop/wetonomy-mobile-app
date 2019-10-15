import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_bloc.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_event.dart';
import 'package:wetonomy/bloc/account_setup/account_setup_state.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/accent_button.dart';
import 'package:wetonomy/screens/create_account/components/create_account_scaffold.dart';
import 'package:wetonomy/screens/create_account/loading_screen.dart';
import 'package:wetonomy/wallet/wallet.dart';

class AccountCreatedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountSetupEvent, AccountSetupState>(
      bloc: BlocProvider.of<AccountSetupBloc>(context),
      builder: (BuildContext context, AccountSetupState state) {
        if (state is AccountSavedState) {
          return CreateAccountScaffold(
              title: Strings.congratulationsLabel,
              body: _buildBody(context, state.wallet));
        }

        return LoadingScreen(title: Strings.savingAccountLabel);
      },
    );
  }

  Widget _buildBody(BuildContext context, Wallet wallet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildStyledText(Strings.congratulationsMessage, context),
              _buildVerticalSpacing(),
              _buildStyledText(
                  'Your wallet address is: ${wallet.address}', context),
              _buildVerticalSpacing(),
              _buildStyledText(Strings.passwordTips, context),
              _buildVerticalSpacing(),
              _buildStyledText(Strings.cantRecoverMessage, context),
            ],
          ),
          AccentButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/terminal'),
            label: Strings.allDoneLabel,
          )
        ],
      ),
    );
  }

  Widget _buildVerticalSpacing() => SizedBox(height: 16);

  Widget _buildStyledText(String text, BuildContext context) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .subhead
            .apply(fontFamily: 'Montserrat'));
  }
}
