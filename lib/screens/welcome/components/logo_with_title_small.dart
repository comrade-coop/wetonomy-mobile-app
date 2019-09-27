import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wetonomy/constants/strings.dart';

class LogoWithTitleSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SvgPicture.asset(
          'assets/images/logo_purple.svg',
          width: 32,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          Strings.appName.toUpperCase(),
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
