import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'WetonomyIconButton.dart';
import 'dummy_data.dart';
import 'group_card.dart';
import 'member_card.dart';

import 'sliver_appbar_delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum View { group, member }

class _MyHomePageState extends State<MyHomePage> {
  bool showGroup = true;
  View current = View.group;

  void switchView(value) {
    if (showGroup != value)
      setState(() {
        showGroup = value;
      });
  }

  Widget appBar() {
    return Padding(
        padding: EdgeInsets.only(top: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            WetonomyIconButton(IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black54,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            )),
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
  Widget build(BuildContext context) {
    final groupCards =
        List<Widget>.generate(groups.length, (i) => GroupCard(groups[i]));
    final memberCards =
        List<Widget>.generate(members.length, (i) => MemberCard(members[i]));
    var currentView = (this.showGroup ? groupCards : memberCards);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   leading: WetonomyIconButton([IconButton(
      //                                       icon: Icon(
      //                                         Icons.person,
      //                                         size: 42,
      //                                         color: Colors.black54,
      //                                       ),
      //                                       onPressed: () =>
      //                                           this.switchView(true),
      //                                     )]),
      //   title: Text("Ketap"),),

      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(236, 236, 236, 1),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                    minHeight: 100.0,
                    maxHeight: 250.0,
                    child: LayoutBuilder(
                      builder: (context, BoxConstraints constraints) {
                        double persentage = (constraints.maxHeight - 100) / 150;
                        double size = 40 + 90 * persentage;
                        double width = MediaQuery.of(context).size.width;

                        double rightMargin =
                            42 + (width / 2 - 105) * persentage;
                        double topMargin = 33 + persentage * 70;

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
                            // color: Colors.lightBlue,
                            child: Stack(
                              children: <Widget>[
                                appBar(),
                                Positioned(
                                  right: width / 2 - 40 * persentage,
                                  top: 43,
                                  child: Text(
                                    "Groups",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        shadows: [
                                          Shadow(
                                              blurRadius: 3.5,
                                              color: Colors.white)
                                        ]),
                                  ),
                                ),
                                Positioned(
                                    top: 22 + topMargin,
                                    right: 4,
                                    child: Opacity(
                                      opacity: (constraints.maxHeight == 250
                                          ? 1
                                          : 0),
                                      child: WetonomyIconButton(
                                        IconButton(
                                            icon: Icon(
                                              (this.showGroup
                                                  ? Icons.person
                                                  : Icons.people),
                                              size: 42,
                                              color: Colors.black54,
                                            ),
                                            onPressed: () => {
                                                  if (!this.showGroup)
                                                    {this.switchView(true)}
                                                  else
                                                    this.switchView(false)
                                                }),
                                        size: 40 + 20 * persentage,
                                      ),
                                    )),
                                Positioned(
                                    top: 25,
                                    right: 66,
                                    child: Opacity(
                                      opacity: (constraints.maxHeight > 150
                                          ? 0
                                          : 1 - persentage),
                                      child: WetonomyIconButton(
                                        IconButton(
                                            icon: Icon(
                                              Icons.search,
                                              color: Colors.black54,
                                            ),
                                            onPressed: () => {}
                                            // this.switchView(true),
                                            ),
                                      ),
                                    )),
                                Positioned(
                                    top: topMargin,
                                    right: rightMargin,
                                    child: Container(
                                        width: size * 1,
                                        height: size,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              33 * persentage),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 3.0,
                                            )
                                          ],
                                        ),
                                        child: IconButton(
                                            icon: Icon(
                                              (!this.showGroup
                                                  ? Icons.person
                                                  : Icons.people),
                                              size: size * 0.7,
                                              color: Colors.black54,
                                            ),
                                            onPressed: () => {}))),
                              ],
                            ));
                      },
                    ))),
          ];
        },
        body: ListView(
          children: <Widget>[...currentView],
        ),
      ),
    );
  }
}
