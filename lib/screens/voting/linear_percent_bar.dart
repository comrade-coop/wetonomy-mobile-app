import 'package:flutter/material.dart';

class LinearPercentBar extends StatelessWidget {
  final double percentage;
  LinearPercentBar(this.percentage);

  @override
  Widget build(BuildContext context) {
    int x = percentage.round();
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Container(child: Text()),
                  Container(child: Text('Yes  $percentage%'))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Container(child: Text(voteMessage)),
                  Container(child: Text('No  ${100 - percentage}%'))
                ],
              ),
            ),
          ],
        ),
        Container(
            height: 12,
            margin: const EdgeInsets.fromLTRB(18, 2, 18, 0),
            child: Row(
              children: <Widget>[
                if (x != 0)
                  Flexible(
                    flex: x,
                    child: Container(
                      height: 12,
                      width: 500,
                      child: Container(),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: x == 100
                              ? BorderRadius.circular(40.0)
                              : BorderRadius.horizontal(
                                  left: Radius.circular(40.0))),
                    ),
                  ),
                if (x != 0 && x != 100)
                Flexible(
                  flex: 1,
                  child: 
                  Container(
                    width: 1,
                    color: Colors.white,
                  ),),
                if (100 - x != 0)
                  Flexible(
                    flex: 100 - x,
                    child: Container(
                      height: 12,
                      width: 500,
                      child: Container(),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: x == 0
                              ? BorderRadius.circular(40.0)
                              : BorderRadius.horizontal(
                                  right: Radius.circular(40.0))),
                    ),
                  )
              ],
            ))
      ],
    );
  }
}
