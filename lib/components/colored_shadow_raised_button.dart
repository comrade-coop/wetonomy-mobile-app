import 'package:flutter/material.dart';

class ColoredShadowRaisedButton extends StatelessWidget {
  final Color color;
  final Color shadowColor;
  final Widget child;
  final EdgeInsets padding;
  final void Function() onPressed;
  final Offset shadowOffset;
  final double blurRadius;
  final double spreadRadius;

  const ColoredShadowRaisedButton(
      {Key key,
      this.color,
      this.shadowColor,
      this.onPressed,
      this.child,
      this.padding,
      this.shadowOffset,
      this.blurRadius = 8,
      this.spreadRadius = 0.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: shadowColor ?? color,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
          offset: shadowOffset ?? Offset.zero
        )
      ]),
      child: RaisedButton(
        padding: padding,
        elevation: 0,
        highlightElevation: 0,
        child: child,
        onPressed: onPressed,
        color: color,
      ),
    );
  }
}
