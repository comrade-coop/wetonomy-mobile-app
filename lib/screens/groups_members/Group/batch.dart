import 'package:flutter/material.dart';

class Batch extends StatelessWidget {
  final String text;

  const Batch(this.text, {Key key}) : super(key: key);
  @override
  Widget build(Object context) {
    return Container(
      margin: EdgeInsets.only(left: 5),
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 20,
      // width: 50,

      decoration: BoxDecoration(
        color: Color.fromRGBO(12, 191, 65, 1),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
          child: Text(this.text,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 10.0,
              ))),
    );
  }
}