import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';

import '../components/account_action_buttons.dart';
import '../components/logo_with_title.dart';

class WelcomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            LogoWithTitle(),
            SizedBox(
              height: 32,
            ),
            _buildMessage(context),
            SizedBox(
              height: 8,
            ),
            AccountActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          Strings.welcomeMsg,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline.apply(
              fontFamily: 'Montserrat',
              fontWeightDelta: 1,
              color: Colors.white),
        ),
      ],
    );
  }
}
