import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextButton({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RaisedButton(
      onPressed: onPressed,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          Strings.nextLabel,
          style: theme.textTheme.button.apply(color: theme.accentColor),
        ),
      ),
    );
  }
}
