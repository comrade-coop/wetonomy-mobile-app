import 'package:flutter/material.dart';
import 'package:wetonomy/components/waves_background.dart';

class WavesBackgroundContainer extends StatelessWidget {
  static const _waveHeightPercentage = 0.37;

  final Widget child;

  const WavesBackgroundContainer({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

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
          child: child,
          top: true,
          left: true,
          right: true,
          bottom: true,
        ),
      ]),
    );
  }
}
