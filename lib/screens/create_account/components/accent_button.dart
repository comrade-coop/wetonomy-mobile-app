import 'package:flutter/material.dart';

class AccentButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const AccentButton({Key key, @required this.label, @required this.onPressed})
      : assert(label != null),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
        ),
      ),
    );
  }
}
