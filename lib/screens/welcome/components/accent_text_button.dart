import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';

class AccentTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const AccentTextButton(
      {Key key, @required this.label, @required this.onPressed})
      : assert(label != null),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RaisedButton(
      onPressed: onPressed,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          label,
          style: theme.textTheme.button.apply(color: theme.accentColor),
        ),
      ),
    );
  }
}
