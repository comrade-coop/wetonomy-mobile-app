import 'package:flutter/material.dart';
import 'package:wetonomy/screens/groups_members/components/batch.dart';

import 'group_details.dart';
import '../models/group.dart';

class GroupCard extends StatelessWidget {
  final Group group;

  const GroupCard(this.group, {Key key}) : super(key: key);

  static const cardMargin = EdgeInsets.fromLTRB(20, 30, 20, 20);

  @override
  Widget build(BuildContext context) {
    final memberIcons = List<Widget>.generate(
        (group.members.length < 6 ? group.members.length : 6),
        (i) => memberIcon(group.members[i].iconAddress));

    final permissions = List<Widget>.generate(
        (group.permissions.length < 2 ? group.permissions.length : 2),
        (i) => Batch(group.permissions[i].contractName));

    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GroupDetails(this.group)));
        },
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: cardMargin.top + 6),
                margin: cardMargin,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          offset: Offset.fromDirection(2.0),
                          color: Colors.black26)
                    ]),
                height: 140,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 8, 18, 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("Permissions:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              )),
                          ...permissions
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Members:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              )),
                          ...memberIcons
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Address:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              )),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            width: 210,
                            child: Text("${group.address}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                )),
            cardHeader(context, group.name, group.members.length),
          ],
        ));
  }

  Widget memberIcon(icon) {
    return Container(
      margin: EdgeInsets.only(left: 6),
      decoration: new BoxDecoration(
          border:
              Border.all(color: Color.fromRGBO(118, 56, 251, 1), width: 0.5),
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill, image: new NetworkImage(icon))),
      width: 20,
      height: 20,
    );
  }

  Widget cardHeader(BuildContext context,String groupName,int memberCount) {
    return Container(
        margin: EdgeInsets.fromLTRB(cardMargin.left, cardMargin.top - 15,
            cardMargin.right, cardMargin.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 70),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.0, 6.0),
                        colors: <Color>[
                          Theme.of(context).primaryColor,
                          Theme.of(context).accentColor,
                        ]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          offset: Offset.fromDirection(2.0),
                          color: Colors.black26)
                    ]),
                child: Center(
                  child: Text(groupName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 18.0,
                      )),
                ),
                width: 200,
                height: 50,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.0, 2.0),
                      colors: <Color>[
                          Theme.of(context).accentColor,
                          Theme.of(context).primaryColor,
                      ]),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        offset: Offset.fromDirection(2.0),
                        color: Colors.black26)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 26,
                      )),
                  Text(memberCount.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 18.0,
                      )),
                ],
              ),
              width: 85,
              height: 45,
            ),
          ],
        ));
  }
}
