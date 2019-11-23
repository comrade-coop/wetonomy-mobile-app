import 'package:flutter/material.dart';

class LinearPercentBar extends StatelessWidget {
  final double percentage;
  final Color voteColor;
  final String voteMessage;
  LinearPercentBar(this.percentage, this.voteColor, this.voteMessage);

  @override
  Widget build(BuildContext context) {
    int x = percentage.round();
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(24, 8, 24, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(child: Text(voteMessage)),
              Container(child: Text('$percentage%'))
            ],
          ),
        ),
        Container(
            height: 12,
            margin: const EdgeInsets.fromLTRB(18, 2, 18, 0),
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(40.0)),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: x,
                  child: Container(
                    height: 12,
                    width: 500,
                    child: Container(),
                    decoration: BoxDecoration(
                        color: voteColor,
                        borderRadius: BorderRadius.circular(40.0)),
                  )
                ,),
                Flexible(flex: 100-x, child: Container(),)
              ],
            ))
      ],
    );
  }
}