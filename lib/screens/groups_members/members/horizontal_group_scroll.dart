import 'package:flutter/material.dart';

import '../batch.dart';
import '../models/group.dart';

// main() => runApp(MaterialApp(home: MyHomePage()));

class HorizontalGroupScroll extends StatefulWidget {
  final List<Group> groups;

  const HorizontalGroupScroll(this.groups, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _HorizontalGroupScrollState(this.groups);
}

class _HorizontalGroupScrollState extends State<HorizontalGroupScroll> {
  final List<Group> groups;

  int _index = 0;

  _HorizontalGroupScrollState(this.groups) {
    _index = (this.groups.length / 2).floor();
  }

  Widget groupIcon(icon) {
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
  
  @override
  Widget build(BuildContext context) {
    List<List<Widget>> memberIcons = new List<List<Widget>>();
    List<List<Widget>> permissions = new List<List<Widget>>();
    
    groups.forEach((group) {
      final icons = List<Widget>.generate(
        (group.members.length < 3 ? group.members.length : 3),
        (i) => memberIcon(group.members[i].iconAddress));
      memberIcons.add(icons);

      final perm = [Batch(group.permissions[0].contractName.substring(0, 3)), Batch(group.permissions[0].contractName[0], size: 1,)];
      permissions.add(perm);
    });
    

    return Center(
        child: SizedBox(
      height: 150,
      child: PageView.builder(
        itemCount: groups.length,
        controller: PageController(viewportFraction: 0.46, initialPage: _index),
        onPageChanged: (int index) => setState(() => _index = index),
        itemBuilder: (_, i) {
          return LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Transform.scale(
                scale: i == _index ? 1 : 0.8,
                child: Opacity(
                  opacity: i == _index ? 1 : 0.8,
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.0),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(blurRadius: 5, color: Colors.white)
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: 55,
                              width: 171,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment(0.0, 4.0),
                                      colors: <Color>[
                                        Color.fromRGBO(118, 56, 251, 1),
                                        Color.fromRGBO(243, 144, 176, 1),
                                      ]),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25),
                                    bottom: Radius.circular(15),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1,
                                        offset: Offset(0, 1),
                                        color: Colors.black54)
                                  ]),
                              child: Center(
                                child: Text("${groups[i].name}",
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      shadows: [
                                        Shadow(
                                            blurRadius: 1.5,
                                            color: Colors.white)
                                      ],
                                    )),
                              )),
                          if (constraints.maxHeight > 120)
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: <Widget>[
                                  Text("Members:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0,
                                      )),
                                  ...memberIcons[i]
                                ],
                              ),
                            ),
                          if (constraints.maxHeight > 145)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                              children: <Widget>[
                                Text("Permissions:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0,
                                    )),
                                ...permissions[i]
                              ],
                            ),)
                            
                        ],
                      )),
                ));
          });
        },
      ),
    ));
  }

  Widget memberIcon(icon) {
    return Container(
      margin: EdgeInsets.only(left: 4),
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
}
