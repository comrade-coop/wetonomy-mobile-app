import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';

import 'package:wetonomy/screens/shared/sliver_appbar_delegate.dart';
import 'package:wetonomy/screens/shared/wetonomy_app_bar.dart';
import 'package:wetonomy/screens/shared/wetonomy_icon_button.dart';

import '../terminal/components/terminal_drawer_container.dart';
import 'dummy_data.dart';
import './group/group_card.dart';
import './members/member_card.dart';
class GroupsMembersTerminal extends StatefulWidget {
  GroupsMembersTerminal({Key key, this.title}) : super(key: key);

  final String title;

  @override
  GroupsMembersTerminalState createState() => GroupsMembersTerminalState();
}

enum View { group, member }

class GroupsMembersTerminalState extends State<GroupsMembersTerminal> {
  bool showGroup = true;
  View current = View.group;

  void switchView(value) {
    if (showGroup != value)
      setState(() {
        showGroup = value;
      });
  }

  @override
  Widget build(BuildContext context) {
    // final accountsBlock = BlocProvider.of<AccountsBloc>(context);
    // final AccountsState state = accountsBlock.currentState;
    // String currentUserAddress;
    // if (state is LoggedInState) {
    //   currentUserAddress = state.wallet.address;
    // }

    final groupCards =
        List<Widget>.generate(groups.length, (i) => GroupCard(groups[i]));
    final memberCards =
        List<Widget>.generate(members.length, (i) => MemberCard(members[i]));
    var currentView = (this.showGroup ? groupCards : memberCards);

    return Scaffold(
      drawer: TerminalDrawerContainer(),
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
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).accentColor,
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
                                // AppBar(),
                                Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: WetonomyAppBar(
                                  "",
                                  currentUserMetaData,
                                  leading: WetonomyIconButton(IconButton(
                                    icon: Icon(
                                      Icons.menu,
                                      color: Colors.black54,
                                    ),
                                    onPressed: () =>
                                        Scaffold.of(context).openDrawer(),
                                  )),
                                )),
                                Positioned(
                                  right: width / 2 - 52 * persentage,
                                  top: 43,
                                  child: Container(
                                      width: 105,
                                      child: Center(
                                        child: Text(
                                          this.showGroup ? "Groups" : "Members",
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
                                      )),
                                ),
                                Positioned(
                                    top: 22 + topMargin,
                                    right: 4,
                                    child: Opacity(
                                      opacity:
                                          (constraints.maxHeight > 230 ? 1 : 0),
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
                                      child: Icon(
                                        (!this.showGroup
                                            ? Icons.person
                                            : Icons.people),
                                        size: size * 0.7,
                                        color: Colors.black54,
                                      ),
                                    )),
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
