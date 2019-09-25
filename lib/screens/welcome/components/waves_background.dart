import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WavesBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
          gradients: [
            [
              Color.fromARGB(255, 131, 111, 254).withAlpha(170),
              Color.fromARGB(255, 225, 153, 184).withAlpha(100)
            ],
            [
              Color.fromARGB(255, 131, 111, 254).withAlpha(170),
              Color.fromARGB(255, 225, 153, 184).withAlpha(100)
            ],
          ],
          durations: [
            30000,
            40000
          ],
          heightPercentages: [
            0.38,
            0.40
          ],
          gradientBegin: Alignment.bottomLeft,
          gradientEnd: Alignment.centerRight),
      waveAmplitude: 25,
      size: Size(double.infinity, double.infinity),
    );
  }
}
