import 'package:flutter/material.dart';

class MnemonicWord extends StatelessWidget {
  final String word;
  final VoidCallback onSelected;
  final bool selected;

  const MnemonicWord(
      {Key key,
      @required this.word,
      @required this.onSelected,
      @required this.selected})
      : assert(word != null),
        assert(onSelected != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return OutlineButton(
        color: Colors.transparent,
        onPressed: null,
        disabledBorderColor: Theme.of(context).accentColor.withAlpha(30),
        child: Text(word, style: TextStyle(color: Colors.transparent)),
      );
    }

    return FlatButton(
      color: Theme.of(context).accentColor.withAlpha(30),
      onPressed: onSelected,
      child: Text(
        word,
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
    );
  }
}
