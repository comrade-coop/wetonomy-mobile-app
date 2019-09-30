import 'package:flutter/material.dart';
import 'package:wetonomy/screens/welcome/components/waves_background.dart';
import 'package:wetonomy/screens/welcome/sections/account_created_section.dart';
import 'package:wetonomy/screens/welcome/sections/create_password_section.dart';
import 'package:wetonomy/screens/welcome/sections/view_secret_phrase_section.dart';

import 'sections/welcome_section.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Stack(children: [
        Align(
            alignment: Alignment.bottomCenter,
            child: WavesBackground(
              heightPercentage: 0.74,
            )),
        SafeArea(
          child: AccountCreatedSection(),
          top: true,
          left: true,
          right: true,
          bottom: true,
        ),
      ]),
    );
  }
}
