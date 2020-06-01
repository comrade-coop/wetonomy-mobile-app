import 'package:flutter/material.dart';

class LinearPercentBar extends StatelessWidget {
  final double percentage;
  LinearPercentBar(this.percentage);

  @override
  Widget build(BuildContext context) {
    int x = percentage.round();
    return Container(
        height: 22,
        margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
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
                      color: Colors.green,
                      borderRadius: x == 100
                          ? BorderRadius.vertical(
                              top: Radius.circular(8.0),
                              bottom: Radius.circular(30.0))
                          : BorderRadius.only(
                              topRight: Radius.circular(4.0),
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(4.0),
                            ),
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
                          begin: Alignment(-1.5, 1),
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Color.fromRGBO(243, 144, 176, 1),
                            Color.fromRGBO(118, 56, 251, 1),
                          ]),
                      borderRadius: x == 0
                          ? BorderRadius.vertical(
                              top: Radius.circular(8.0),
                              bottom: Radius.circular(30.0))
                          : BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(8.0),
                              bottomRight: Radius.circular(30.0),
                              bottomLeft: Radius.circular(4.0),
                            ),
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
