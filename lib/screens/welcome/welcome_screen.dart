import 'package:flutter/material.dart';
import 'package:wetonomy/screens/welcome/components/waves_background.dart';

import 'components/welcome_section.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Theme(
      data: ThemeData.dark().copyWith(
          primaryColor: appTheme.primaryColor,
          accentColor: appTheme.accentColor,
          primaryColorDark: appTheme.primaryColorDark,
          primaryColorLight: appTheme.primaryColorLight,
          brightness: appTheme.brightness,
          backgroundColor: appTheme.backgroundColor),
      child: Material(
        child: DecoratedBox(
          decoration: BoxDecoration(color: appTheme.backgroundColor),
          child: Stack(children: [
            Align(alignment: Alignment.bottomCenter, child: WavesBackground()),
            SafeArea(
              child: WelcomeSection(),
              top: true,
              left: true,
              right: true,
              bottom: true,
            ),
          ]),
        ),
      ),
    );
  }
}
