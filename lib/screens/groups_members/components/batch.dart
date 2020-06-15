import 'package:flutter/material.dart';

class Batch extends StatelessWidget {
  final String text;

  final double size;

  const Batch(this.text, {this.size = 5,Key key}) : super(key: key);
  @override
  Widget build(Object context) {
    String _text = text;
    if(text.length>5) _text = text.substring(0, 5);
    return Container(
      margin: EdgeInsets.only(left: 5),
      padding: EdgeInsets.symmetric(horizontal: 3+size),
      height: 10+size,
      // width: 50,

      decoration: BoxDecoration(
        color: Color.fromRGBO(12, 191, 65, 1),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
          child: Text(_text,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 5+size,
              ))),
    );
  }
}