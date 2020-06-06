import 'package:flutter/material.dart';

class PermissionsCount extends StatelessWidget {
  final int count;

  const PermissionsCount(this.count, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                offset: Offset.fromDirection(2.0),
                color: Colors.black26)
          ]),
      child: ListTile(
        leading: Icon(
          Icons.vpn_key,
          color: Color.fromRGBO(118, 55, 245, 1),
        ),
        title: Text('Permissions:  $count',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(118, 55, 245, 1),
              fontSize: 18.0,
            )),
        // trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
