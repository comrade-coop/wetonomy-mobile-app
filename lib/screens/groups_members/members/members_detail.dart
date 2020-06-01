import 'package:flutter/material.dart';
import 'package:wetonomy/screens/groups_members/group/permission_card.dart';
import 'package:wetonomy/screens/groups_members/models/member.dart';
import 'package:wetonomy/screens/groups_members/wetonomy_app_bar.dart';
import 'package:wetonomy/screens/shared/sliver_appbar_delegate.dart';
import 'package:wetonomy/screens/shared/wetonomy_icon_button.dart';

import '../dummy_data.dart';
import 'horizontal_group_scroll.dart';
// import 'permission_card.dart';

class MemberDetails extends StatelessWidget {
  final Member member;

  const MemberDetails(this.member, {Key key}) : super(key: key);

  Widget appBar(context) {
    return Padding(
        padding: EdgeInsets.only(top: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            WetonomyIconButton(IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black54,
              ),
              onPressed: () => Navigator.pop(context),
            )),
            Text(
              "${member.name}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  shadows: [Shadow(blurRadius: 3.5, color: Colors.white)]),
            ),
            WetonomyIconButton(IconButton(
              icon: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTOS7KNcMLI-A9ab3kc9r83EQSpMJWjjTeNkAf1h9ebXIXlwpc6&usqp=CAU',
              ),
              onPressed: () => {},
            ))
          ],
        ));
  }

  @override
  Widget build(Object context) {
    var permissions = List<PermissionCard>.generate(
        this.member.permissions.length,
        (i) => PermissionCard(this.member.permissions[i]));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(236, 236, 236, 1),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                    minHeight: 260.0,
                    maxHeight: 440.0,
                    child: LayoutBuilder(
                      builder: (context, BoxConstraints constraints) {
                        double persentage = (constraints.maxHeight - 260) / 180;
                        print(persentage);
                        double width = MediaQuery.of(context).size.width;

                        // double secondStep = constraints.maxHeight < 220
                        //     ? (constraints.maxHeight - 160) / 60
                        //     : 1;

                        return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment(1.0, 2),
                                  colors: <Color>[
                                    Color.fromRGBO(118, 56, 251, 1),
                                    Color.fromRGBO(243, 144, 176, 1),
                                  ]),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20)),
                            ),
                            child: Stack(
                              overflow: Overflow.visible,
                              children: <Widget>[
                                WetonomyAppBar(
                                  "",
                                  showAvatar: false,
                                ),
                                Positioned(
                                    width: width,
                                    height: 205,
                                    top: 40,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Developer",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18),
                                        ),
                                        Container(
                                          width: 105,
                                          height: 105,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                                color: Colors.white, width: 1),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white,
                                                blurRadius: 3.0,
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                              width: 104,
                                              height: 104,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Image.network(
                                                    member.iconAddress,
                                                    scale: 1.5,
                                                    fit: BoxFit.contain),
                                              )),
                                        ),
                                        Text(
                                          this.member.name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              shadows: [
                                                Shadow(
                                                    blurRadius: 2,
                                                    color: Colors.white)
                                              ]),
                                        ),
                                        Text(this.member.address,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            )),
                                      ],
                                    )),
                                Positioned(
                                    width: width,
                                    top: 127 + 130 * persentage,
                                    child: Opacity(
                                      opacity: persentage,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 12),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Text("Groups",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      118, 55, 245, 1),
                                                  // fontSize: 18.0,
                                                )),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 12),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 4),
                                                    child: Icon(
                                                      Icons.people,
                                                      color: Color.fromRGBO(
                                                          118, 55, 245, 1),
                                                      size: 18,
                                                    )),
                                                Text(member.groups.length.toString(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromRGBO(
                                                          118, 55, 245, 1),
                                                      // fontSize: 18.0,
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                Opacity(
                                    opacity: persentage,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 160 + 100 * persentage),
                                      // margin: EdgeInsets.only(bottom: 20),
                                      child: HorizontalGroupScroll(groups),
                                    ))
                              ],
                            ));
                      },
                    ))),
          ];
        },
        body: ListView(
          children: <Widget>[
            Container(
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
                title: Text('Permissions:  ${member.permissions.length}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color.fromRGBO(118, 55, 245, 1),
                      fontSize: 18.0,
                    )),
                // trailing: Icon(Icons.more_vert),
              ),
            ),
            ...permissions
          ],
        ),
      ),
    );
  }
}
