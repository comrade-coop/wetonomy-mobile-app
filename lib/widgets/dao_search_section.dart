import 'package:flutter/material.dart';

class DaoSearchSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.blue),
        width: 52,
        child: ListView(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              tooltip: 'Search',
              splashColor: Colors.white,
              onPressed: null,
            ),
          ],
        ));
  }
}
