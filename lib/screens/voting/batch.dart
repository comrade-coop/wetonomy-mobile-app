import 'package:flutter/material.dart';

class Batch extends StatelessWidget {
  final Color color;
  final String heading;
  Batch(this.heading, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 18, 12, 0),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 20,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(14.0), bottom: Radius.circular(6.0))),
      child: Center(
        child:
        Text(heading,
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 12)),
    ));
  }
}
