import 'package:flutter/material.dart';

class LinearPercentBar extends StatelessWidget {
  final double percentage;
  final bool inCard;
  LinearPercentBar(this.percentage, {this.inCard = true});

  @override
  Widget build(BuildContext context) {
    int x = percentage.round();
    BorderRadius leftRadius;
    BorderRadius rightRadius;
    double horizontalMargin = 0;
    if (inCard) {
      if (x == 100 || x == 0) {
        leftRadius = BorderRadius.vertical(
            top: Radius.circular(8.0), bottom: Radius.circular(30.0));
        rightRadius = BorderRadius.vertical(
            top: Radius.circular(8.0), bottom: Radius.circular(30.0));
      } else {
        leftRadius = BorderRadius.only(
          topRight: Radius.circular(4.0),
          topLeft: Radius.circular(8.0),
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(4.0),
        );
        rightRadius = BorderRadius.only(
          topLeft: Radius.circular(4.0),
          topRight: Radius.circular(8.0),
          bottomRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(4.0),
        );
      }
    } else {
      if (x == 100 || x == 0) {
        leftRadius = BorderRadius.all(Radius.circular(10.0));
        rightRadius = BorderRadius.all(Radius.circular(10.0));
      }
      else {
        leftRadius = BorderRadius.horizontal(left: Radius.circular(10.0), );
        rightRadius = BorderRadius.horizontal(right: Radius.circular(10.0));
      }
      horizontalMargin = 8;
    }
    return Container(
        height: 22,
        margin: EdgeInsets.fromLTRB(horizontalMargin, 2, horizontalMargin, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (x != 0)
              Flexible(
                flex: x,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20),
                  height: 22,
                  width: 500,
                  child: Text(
                    'Yes  $percentage%',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Colors.green,
                            Colors.green.shade300,
                          ]),
                      // color: Colors.green,
                      borderRadius: leftRadius,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            offset: Offset(1, -1.0),
                            color: Colors.black12)
                      ]),
                ),
              ),
            if (x != 0 && x != 100)
              Flexible(
                flex: 1,
                child: Container(
                  width: 1,
                ),
              ),
            if (100 - x != 0)
              Flexible(
                flex: 100 - x,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  height: 22,
                  width: 500,
                  child: Text(
                    'No  ${100 - percentage}%',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment(-2.5, 1),
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Theme.of(context).accentColor,
                            Theme.of(context).primaryColor,
                          ]),
                      borderRadius: rightRadius,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            offset: Offset(-1, -1.0),
                            color: Colors.black12)
                      ]),
                ),
              )
          ],
        ));
  }
}
