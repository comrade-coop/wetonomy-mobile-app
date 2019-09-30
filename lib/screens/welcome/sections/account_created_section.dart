import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/welcome/components/accent_text_button.dart';
import 'package:wetonomy/screens/welcome/sections/welcome_section_scaffold.dart';

class AccountCreatedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WelcomeSectionScaffold(
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
                SizedBox(height: 16),
                _buildStyledText(Strings.passwordTips, context),
                SizedBox(height: 16),
                _buildStyledText(Strings.cantRecoverMessage, context),
              ],
            ),
            AccentTextButton(
              onPressed: () {},
              label: Strings.allDoneLabel,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStyledText(String text, BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.subhead);
  }
}
