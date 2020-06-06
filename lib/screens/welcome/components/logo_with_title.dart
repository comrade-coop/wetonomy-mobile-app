import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wetonomy/constants/strings.dart';

class LogoWithTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset('assets/images/logo.svg'),
        SizedBox(height: 32),
        Text(
          Strings.appName.toUpperCase(),
          style: Theme.of(context).textTheme.headline4.apply(
              color: Theme.of(context).primaryColor,
              fontFamily: 'Montserrat',
              fontWeightDelta: 700),
        )
      ],
    );
  }
}
