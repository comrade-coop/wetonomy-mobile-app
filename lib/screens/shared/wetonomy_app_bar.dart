import 'package:flutter/material.dart';
import 'package:wetonomy/screens/groups_members/members/members_detail.dart';
import 'package:wetonomy/screens/groups_members/models/member.dart';
import 'package:wetonomy/screens/shared/wetonomy_icon_button.dart';



class WetonomyAppBar extends StatelessWidget {
  final Widget leading;

  final String title;

  final bool showAvatar;

  final Member currentUser;

  const WetonomyAppBar(
    this.title,
    this.currentUser, {
    this.leading,
    this.showAvatar = true,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (this.leading != null)
              this.leading
            else
              WetonomyIconButton(IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black54,
                ),
                onPressed: () => Navigator.pop(context),
              )),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  shadows: [Shadow(blurRadius: 3.5, color: Colors.white)]),
            ),
            if (this.showAvatar)
              WetonomyIconButton(IconButton(
                icon: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTOS7KNcMLI-A9ab3kc9r83EQSpMJWjjTeNkAf1h9ebXIXlwpc6&usqp=CAU',
                ),
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MemberDetails(currentUser)))
                },
              ))
          ],
        );
  }
}
