import 'package:flutter/material.dart';

class AccountInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
