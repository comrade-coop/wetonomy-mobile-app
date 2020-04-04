import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wetonomy/constants/strings.dart';

class LogoWithTitle extends StatelessWidget {
  static const Color _logoColor = Color.fromARGB(255, 131, 111, 254);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset('assets/images/logo.svg'),
        SizedBox(height: 32),
        Text(
          Strings.appName.toUpperCase(),
          style: Theme.of(context).textTheme.display1.apply(
              color: _logoColor,
              fontFamily: 'Montserrat',
              fontWeightDelta: 700),
        )
      ],
    );
  }
}
