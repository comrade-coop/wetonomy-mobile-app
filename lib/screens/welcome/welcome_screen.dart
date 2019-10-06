import 'package:flutter/material.dart';
import 'package:wetonomy/screens/welcome/components/waves_background.dart';

import 'components/welcome_section.dart';

class WelcomeScreen extends StatelessWidget {
  static const _waveHeightPercentage = 0.37;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Stack(children: [
        Align(
            alignment: Alignment.bottomCenter,
            child: WavesBackground(
              heightPercentage: _waveHeightPercentage,
            )),
        SafeArea(
          child: WelcomeSection(),
          top: true,
          left: true,
          right: true,
          bottom: true,
        ),
      ]),
    );
  }
}
