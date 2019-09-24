import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: [
        _buildWavesBackground(context),
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
    return Container(
      width: 150,
      height: 150,
      color: Theme.of(context).accentColor,
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Work with each other, not for one another',
      style: Theme.of(context).textTheme.title.apply(
        color: Colors.white,

      ),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Text(
        'Create new Account',
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
      onPressed: () {},
    );
  }

  Widget _buildImportButton(BuildContext context) {
    return FlatButton(
      color: Colors.black.withAlpha(10),
      child: Text(
        'Import from Seed Phrase',
        style: TextStyle(color: Theme.of(context).textTheme.title.color),
      ),
      onPressed: () {},
    );
  }

  Widget _buildWavesBackground(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: WaveWidget(
        config: CustomConfig(
          gradients: [
            [
              Theme.of(context).accentColor.withAlpha(100),
              Theme.of(context).accentColor.withAlpha(30)
            ],
            [
              Theme.of(context).accentColor.withAlpha(60),
              Theme.of(context).accentColor.withAlpha(10)
            ],
          ],
          durations: [10000, 15000],
          heightPercentages: [0.35, 0.35],
          gradientBegin: Alignment.bottomLeft,
          gradientEnd: Alignment.topRight,
        ),
        waveAmplitude: 20,
        size: Size(double.infinity, double.infinity),
      ),
    );
  }
}
