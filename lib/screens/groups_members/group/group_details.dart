import 'package:flutter/material.dart';
import 'package:wetonomy/screens/shared/sliver_appbar_delegate.dart';
import 'package:wetonomy/screens/shared/wetonomy_icon_button.dart';


import '../models/group.dart';
import '../wetonomy_app_bar.dart';
import 'horizontal_member_scroll.dart';
import 'permission_card.dart';

class GroupDetails extends StatelessWidget {
  final Group group;

  const GroupDetails(this.group, {Key key}) : super(key: key);

  Widget appBar(context) {
    return Padding(
        padding: EdgeInsets.only(top: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            WetonomyIconButton(
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black54,
                ),
                onPressed: () => Navigator.pop(context),
              )
            ),
            Text(
              "${group.name} Group",
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
        this.group.permissions.length,
        (i) => PermissionCard(this.group.permissions[i]));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(236, 236, 236, 1),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                    minHeight: 160.0,
                    maxHeight: 380.0,
                    child: LayoutBuilder(
                      builder: (context, BoxConstraints constraints) {
                        double persentage = constraints.maxHeight > 210
                            ? (constraints.maxHeight - 210) / 170
                            : 0;

                        double width = MediaQuery.of(context).size.width;

                        double secondStep = constraints.maxHeight < 220
                            ? (constraints.maxHeight - 160) / 60
                            : 1;

                        return Container(
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
                                        bottom: Radius.elliptical(
                                            200, 20 + 30 * persentage))),
                                shadows: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset.fromDirection(2.0),
                                      color: Colors.black54)
                                ]),
                            child: Stack(
                              children: <Widget>[
                                WetonomyAppBar("${group.name} Group"),

                                if (secondStep > 0.9)
                                  Positioned(
                                      top: 85,
                                      child: Container(
                                        width: width,
                                        child: Row(children: <Widget>[
                                          WetonomyIconButton(
                                            Icon(
                                              Icons.description,
                                              size: 34,
                                              color: Colors.black54,
                                            ),
                                            size: 50,
                                          ),
                                          Container(
                                              width: width - 80,
                                              padding: EdgeInsets.only(left: 8),
                                              child: Text(
                                                "Gorup for software developers",
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              )),
                                        ]),
                                      )),
                                Positioned(
                                  top: 80 + 65.0 * secondStep, //* persentage,
                                  child: Row(children: <Widget>[
                                    WetonomyIconButton(
                                      Icon(
                                        Icons.group,
                                        size: 24 + 10 * secondStep,
                                        color: Colors.black54,
                                      ),
                                      size: 40 + 10 * secondStep,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 20, 0),
                                      child: Text(
                                        "Members count: ${group.members.length}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    WetonomyIconButton(
                                      Icon(
                                        Icons.person_add,
                                        size: 16 + 8 * secondStep,
                                        color: Colors.black54,
                                      ),
                                      size: 30 + 10 * secondStep,
                                    ),
                                    WetonomyIconButton(
                                      Icon(
                                        Icons.person_add,
                                        size: 16 + 8 * secondStep,
                                        color: Colors.black54,
                                      ),
                                      size: 30 + 10 * secondStep,
                                    )
                                  ]),
                                ),
                                Opacity(
                                    opacity: persentage,
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: 100 + 120 * persentage),
                                        child: HorizontalMemberScroll(group.members)))
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
                title: Text('Permissions:  ${group.permissions.length}',
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
