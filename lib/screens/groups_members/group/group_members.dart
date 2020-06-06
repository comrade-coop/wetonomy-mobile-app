import 'package:flutter/material.dart';
import 'package:wetonomy/screens/groups_members/members/member_card.dart';
import 'package:wetonomy/screens/groups_members/models/group.dart';
import 'package:wetonomy/screens/groups_members/models/member.dart';
import 'package:wetonomy/screens/shared/wetonomy_app_bar.dart';

class GroupMembers extends StatelessWidget {
  final Group group;

  final Member currentUser;

  const GroupMembers(this.group, this.currentUser,{Key key}) : super(key: key);

  @override
  Widget build(Object context) {
    final memberCards =
        List<Widget>.generate(group.members.length, (i) => MemberCard(group.members[i]));
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            height: 100,
            decoration: ShapeDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment(0.0, 3.0),
                    colors: <Color>[
                      Color.fromRGBO(118, 56, 251, 1),
                      Color.fromRGBO(243, 144, 176, 1),
                    ]),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(200, 20))),
                shadows: [
                  BoxShadow(
                      blurRadius: 5,
                      offset: Offset.fromDirection(2.0),
                      color: Colors.black54)
                ]),
            child: WetonomyAppBar("${group.name} Group", currentUser),
          ),
        ),
        backgroundColor: Color.fromRGBO(236, 236, 236, 1),
        body: ListView(
          children: <Widget>[
            ...memberCards,
          ],
        ));
  }
}
