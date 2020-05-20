import 'package:flutter/material.dart';

import 'Group/batch.dart';
import 'models/member.dart';

// main() => runApp(MaterialApp(home: MyHomePage()));

class HorizontalScroll extends StatefulWidget {
  final List<Member> members;

  const HorizontalScroll(this.members, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HorizontalScrollState(this.members);
}

class _HorizontalScrollState extends State<HorizontalScroll> {
  final List<Member> members;

  _HorizontalScrollState(this.members);

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

  List<Widget> generateGroups(List<String> groups) {
    return List<Widget>.generate(
        (groups.length < 2 ? groups.length : 2),
        (i) => Batch(groups[i]));
  }

  @override
  Widget build(BuildContext context) {
    int _index = (members.length / 2).floor();
    return Center(
        child: SizedBox(
      height: 200, 
      child: PageView.builder(
        itemCount: members.length,
        controller: PageController(viewportFraction: 0.48,initialPage: _index),
        onPageChanged: (int index) => setState(() => _index = index),
        itemBuilder: (_, i) {
          return LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Transform.scale(
                scale: i == _index ? 1 : 0.8,
                child: Opacity(
                  opacity: i == _index ? 1 : 0.8,
                  child: Container(
                      margin: EdgeInsets.only(top: 6),
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
                            height: 70,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment(0.0, 4.0),
                                    colors: <Color>[
                                      Color.fromRGBO(118, 56, 251, 1),
                                      Color.fromRGBO(243, 144, 176, 1),
                                    ]),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1,
                                      offset: Offset(0, 1),
                                      color: Colors.black54)
                                ]),
                            child: Row(
                              children: <Widget>[
                                memberIcon(members[i].iconAddress),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  width: 80,
                                  child: Text("${members[i].name}",
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
                                )
                              ],
                            ),
                          ),
                          if (constraints.maxHeight > 130)
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Groups:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0,
                                      )),
                                  ...generateGroups(members[i].groups)
                                ],
                              ),
                            ),
                          if (constraints.maxHeight > 145)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Position:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0,
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
                ));
          });
        },
      ),
    ));
  }
}
