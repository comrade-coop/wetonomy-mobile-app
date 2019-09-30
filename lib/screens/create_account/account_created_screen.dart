import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/accent_button.dart';
import 'package:wetonomy/screens/create_account/components/create_account_scaffold.dart';

class AccountCreatedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CreateAccountScaffold(
      title: Strings.congratulationsLabel,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildStyledText(Strings.congratulationsMessage, context),
                _buildVerticalSpacing(),
                _buildStyledText(Strings.passwordTips, context),
                _buildVerticalSpacing(),
                _buildStyledText(Strings.cantRecoverMessage, context),
              ],
            ),
            AccentButton(
              onPressed: () => _openTerminalScreen(context),
              label: Strings.allDoneLabel,
            )
          ],
        ),
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

  void _openTerminalScreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/terminal', (Route<dynamic> route) => false);
  }
}
