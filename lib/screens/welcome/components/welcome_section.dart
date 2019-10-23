import 'package:flutter/material.dart';
import 'package:wetonomy/components/waves_background_container.dart';
import 'package:wetonomy/constants/strings.dart';

import 'account_action_buttons.dart';
import 'logo_with_title.dart';

class WelcomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WavesBackgroundContainer(
      child: Container(
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
