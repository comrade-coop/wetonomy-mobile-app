import 'package:flutter/material.dart';

import '../batch.dart';
import '../models/member.dart';
import 'members_detail.dart';

class MemberCard extends StatelessWidget {
  final Member member;

  const MemberCard(this.member, {Key key}) : super(key: key);

  static const cardMargin = EdgeInsets.fromLTRB(20, 20, 20, 20);

  @override
  Widget build(BuildContext context) {
    final groups = List<Widget>.generate(
        (member.groups.length < 2 ? member.groups.length : 2),
        (i) => Batch(member.groups[i]));
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MemberDetails(this.member)));
        },
        child:  Container(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                // margin: EdgeInsets.only(right: 70),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.0, 3.0),
                        colors: <Color>[
                          Color.fromRGBO(118, 56, 251, 1),
                          Color.fromRGBO(243, 144, 176, 1),
                        ]),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          offset: Offset.fromDirection(2.0),
                          color: Colors.black54)
                    ]),
                child: Container(
                  padding: EdgeInsets.only(right: 8),
                  child: Row(children: <Widget>[
                    memberIcon(member.iconAddress),
                    Container(
                      width: 85,
                      child: Text(member.name,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                    )
                  ]),
                ),
                height: 80,
                width: 165,
              ),
              Container(
                  height: 80,
                  width: 155,
                  padding: EdgeInsets.fromLTRB(5, 14, 5, 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("Groups:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              )),
                          ...groups
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Position:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              )),
                          Text("  Developer",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              )),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(18, 8, 18, 8),
              child: Row(
                children: <Widget>[
                  Text("Address:",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    width: 210,
                    child: Text("${member.address}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        )),
                  )
                ],
              ))
        ],
      ),
    ));
  }

  Widget memberIcon(icon) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: new BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.white, blurRadius: 2)],
          image: new DecorationImage(
              fit: BoxFit.fill, image: new NetworkImage(icon))),
      width: 55,
      height: 55,
    );
  }

  Widget cardHeader(groupName, memberCount) {
    return Container(
        margin: EdgeInsets.fromLTRB(cardMargin.left, cardMargin.top - 15,
            cardMargin.right, cardMargin.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Expanded(
            //   child:
            // ),
          ],
        ));
  }
}
