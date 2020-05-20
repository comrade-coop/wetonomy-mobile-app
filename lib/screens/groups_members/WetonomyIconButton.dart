import 'package:flutter/material.dart';

class WetonomyIconButton extends StatelessWidget {
  final Widget child;
  final double size;

  const WetonomyIconButton(this.child, {this.size = 40,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size ,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 3.0,
            )
          ],
        ),
        child: this.child);
  }
}
