import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WavesBackground extends StatelessWidget {
  final double heightPercentage;

  const WavesBackground({Key key, this.heightPercentage = 0.38})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryDark = Theme.of(context).primaryColorDark;
    final Color accentColor = Theme.of(context).accentColor;

    return WaveWidget(
      config: CustomConfig(
          gradients: [
            [primaryDark.withAlpha(180), accentColor.withAlpha(110)],
            [primaryDark.withAlpha(150), accentColor.withAlpha(90)],
          ],
          durations: [
            40000,
            50000
          ],
          heightPercentages: [
            this.heightPercentage,
            this.heightPercentage + 0.03
          ],
          blur: MaskFilter.blur(BlurStyle.solid, 10),
          gradientBegin: Alignment.bottomLeft,
          gradientEnd: Alignment.centerRight),
      waveAmplitude: 25,
      size: Size(double.infinity, double.infinity),
    );
  }
}
