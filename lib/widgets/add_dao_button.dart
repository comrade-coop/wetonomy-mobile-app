import 'package:flutter/material.dart';

class AddDaoButton extends StatelessWidget {
  final Function _onAddNewDao;

  AddDaoButton(this._onAddNewDao);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Icon(
        Icons.add,
        color: Colors.blue,
        size: 32,
      ),
      color: Colors.black.withAlpha(10),
      padding: EdgeInsets.all(8),
      shape: CircleBorder(),
      splashColor: Colors.grey,
      onPressed: _onAddNewDao,
    );
  }
}
