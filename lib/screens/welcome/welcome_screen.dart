import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:wetonomy/screens/welcome/components/waves_background.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: [
        Align(alignment: Alignment.bottomCenter, child: WavesBackground()),
        _buildContent(context),
      ]),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildLogo(context),
            _buildTitle(context),
            Container(
              constraints: BoxConstraints(maxWidth: 300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildCreateAccountButton(context),
                  SizedBox(height: 16),
                  _buildImportButton(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset('assets/images/logo.svg'),
        SizedBox(height: 32),
        Text(
          'WETONOMY',
          style: Theme.of(context).textTheme.display1.apply(
              color: Color.fromARGB(255, 131, 111, 254),
              fontFamily: 'Montserrat',
              fontWeightDelta: 700),
        )
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 64,
        ),
        Text(
          'Work with each other,\n not for one another',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline.apply(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontWeightDelta: 2),
        ),
      ],
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Create new Account',
          style: TextStyle(color: Colors.deepPurple, fontFamily: 'Montserrat'),
        ),
      ),
      onPressed: () {},
    );
  }

  Widget _buildImportButton(BuildContext context) {
    return FlatButton(
      color: Colors.black.withAlpha(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Import from Seed Phrase',
          style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
        ),
      ),
      onPressed: () {},
    );
  }
}
