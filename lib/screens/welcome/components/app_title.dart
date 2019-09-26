import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';

class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      Strings.appName.toUpperCase(),
      style: TextStyle(
          color: Theme.of(context).accentColor,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700),
    );
  }
}
