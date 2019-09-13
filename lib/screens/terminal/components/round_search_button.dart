import 'package:flutter/material.dart';

class RoundSearchButton extends StatelessWidget {
  final Function onPressed;

  RoundSearchButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          Icons.search,
          color: Theme.of(context).accentColor,
        ),
      ),
      color: Colors.black.withAlpha(10),
      padding: EdgeInsets.all(8),
      shape: CircleBorder(),
      splashColor: Colors.grey,
      onPressed: onPressed,
    );
  }
}
