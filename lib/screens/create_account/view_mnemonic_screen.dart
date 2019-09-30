import 'package:flutter/material.dart';
import 'package:wetonomy/components/slide_right_transition.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/accent_button.dart';
import 'package:wetonomy/screens/create_account/confirm_mnemonic_screen.dart';
import 'package:wetonomy/screens/create_account/components/create_account_scaffold.dart';

class ViewMnemonicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CreateAccountScaffold(
      title: Strings.secretPhraseLabel,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(Strings.secretPhraseMessage),
                    SizedBox(
                      height: 8,
                    ),
                    Text(Strings.secretPhraseStorageMessage),
                    SizedBox(
                      height: 8,
                    ),
                    _buildMnemonicCard(context),
                    SizedBox(
                      height: 8,
                    ),
                    Text(Strings.secretPhraseWarning),
                  ],
                ),
              ),
              AccentButton(
                onPressed: () => Navigator.push(
                    context, slideRightTransition(ConfirmMnemonicScreen())),
                label: Strings.nextLabel,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMnemonicCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24),
          child: Text(
            'witch collapse practice feed shame open despair creek road again ice least',
            style: Theme.of(context).textTheme.headline,
            textAlign: TextAlign.center,
          )),
    );
  }
}
