import 'package:flutter/material.dart';
import 'package:wetonomy/components/waves_background_container.dart';
import 'package:wetonomy/screens/welcome/components/welcome_section.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WavesBackgroundContainer(
      child: Container(
        child: Center(
          child: WelcomeSection(),
        ),
      ),
    );
  }
}
