import 'package:flutter/material.dart';
import 'package:wetonomy/components/slide_right_transition.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/accent_button.dart';
import 'package:wetonomy/screens/create_account/account_created_screen.dart';
import 'package:wetonomy/screens/create_account/components/create_account_scaffold.dart';

class ConfirmMnemonicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                onPressed: () => Navigator.push(
                    context, slideRightTransition(AccountCreatedScreen()))),
          ],
        ),
      ),
    );
  }
}
