import 'package:flutter/material.dart';

class DaoDrawerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.black.withAlpha(10)),
        width: 64,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ListView(
            children: <Widget>[
              FlatButton(
                child: Icon(
                  Icons.add,
                  color: Colors.blue,
                  size: 32,
                ),
                color: Colors.black.withAlpha(10),
                padding: EdgeInsets.all(8),
                shape: CircleBorder(),
                splashColor: Colors.grey,
                onPressed: () => print('dee'),
              ),
            ],
          ),
        ));
  }
}
