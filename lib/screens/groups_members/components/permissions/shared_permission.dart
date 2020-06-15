import 'package:flutter/material.dart';
import 'package:wetonomy/screens/shared/show_modal.dart';

class SharedPermission extends StatelessWidget with ShowModal {
  final String name;

  final Function setActive;

  final bool isActive;

  final int index;

  final bool isPersonalPage;

  SharedPermission(
      this.name, this.setActive, this.isActive, this.index, this.isPersonalPage,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _trailing = Text("");
    if (this.isPersonalPage && this.isActive)
      _trailing = IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => super.showModalSheetConfirmation(context));
    return Material(
        color: Colors.white,
        child: ListTile(
          leading: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
                size: 22,
              )),
          title: Text(
            this.name,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          trailing: _trailing,
          onTap: () => setActive(index),
        ));
  }
}
