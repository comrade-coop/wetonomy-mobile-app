import 'package:flutter/material.dart';
import 'package:wetonomy/components/account_avatar.dart';

class AccountInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                AccountAvatar(),
                Text('Username'),
                SizedBox(
                  width: 12,
                ),
                Text(
                  '0x00000000...',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.caption.color),
                )
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
