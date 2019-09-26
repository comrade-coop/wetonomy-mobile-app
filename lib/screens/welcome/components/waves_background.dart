import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WavesBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryDark = Theme.of(context).primaryColorDark;
    final Color primaryLight = Theme.of(context).primaryColorLight;

    return WaveWidget(
      config: CustomConfig(
          gradients: [
            [primaryDark.withAlpha(180), primaryLight.withAlpha(110)],
            [primaryDark.withAlpha(150), primaryLight.withAlpha(90)],
          ],
          durations: [
            40000,
            50000
          ],
          heightPercentages: [
            0.38,
            0.40
          ],
          blur: MaskFilter.blur(BlurStyle.solid, 10),
          gradientBegin: Alignment.bottomLeft,
          gradientEnd: Alignment.centerRight),
      waveAmplitude: 25,
      size: Size(double.infinity, double.infinity),
    );
  }
}
