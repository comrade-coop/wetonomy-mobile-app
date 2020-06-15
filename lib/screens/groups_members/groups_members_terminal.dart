import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/screens/groups_members/models/group.dart';
import 'package:wetonomy/screens/groups_members/models/member.dart';

import 'package:wetonomy/screens/shared/sliver_appbar_delegate.dart';
import 'package:wetonomy/screens/shared/terminal_interaction.dart';
import 'package:wetonomy/screens/shared/wetonomy_app_bar.dart';
import 'package:wetonomy/screens/shared/wetonomy_icon_button.dart';

import '../terminal/components/terminal_drawer_container.dart';
import './group/group_card.dart';
import './members/member_card.dart';

class GroupsMembersTerminal extends StatefulWidget {
  GroupsMembersTerminal({Key key, this.title}) : super(key: key);

  final String title;

  @override
  GroupsMembersTerminalState createState() => GroupsMembersTerminalState();
}

enum View { group, member }

class GroupsMembersTerminalState extends State<GroupsMembersTerminal>
    with TerminalInteraction {
  bool showGroup = true;
  View current = View.group;
  List<Group> groups = [];
  List<Member> members = [];
  //temporary
  Member currentUserMetaData;

  @override
  void initState() {
    super.initState();

    super.terminalInteractionBloc =
        BlocProvider.of<TerminalInteractionBloc>(context);

    // super.terminalInteractionBlocSubscription =
    //     terminalInteractionBloc.state.listen(_handleTerminalStateChange);

    super
        .terminalInteractionBloc
        .add(ReceiveQueryFromTerminalEvent(Query("GroupsAndMembersFactory")));
  }

  @override
  void dispose() {
    super.terminalInteractionBlocSubscription?.cancel();
    super.dispose();
  }

  // void _handleTerminalStateChange(TerminalInteractionState state) {
  //   // else if (state is ...) {}
  // }

  void switchView(value) {
    if (showGroup != value)
      setState(() {
        showGroup = value;
      });
  }
  //
  // get data from blockchain with Query
  // ask for Members and Groups

  @override
  Widget build(BuildContext context) {
    double minHeight = 100.0;
    double maxHeight = 250.0;

    // final accountsBlock = BlocProvider.of<AccountsBloc>(context);
    // final AccountsState state = accountsBlock.currentState;
    // String currentUserAddress;
    // if (state is LoggedInState) {
    //   currentUserAddress = state.wallet.address;
    // }

    

    return BlocConsumer<TerminalInteractionBloc, TerminalInteractionState>(
        listener: (BuildContext context, state) {
      if (state is ReceiveActionFromTerminalState) {
        showSnackBar("Sending Action", snackBarColor);
      }
      
    }, builder: (context, state) {
      if (state is ReceivedQueryResultState &&
          state.result.query.contractAddress == "GroupsAndMembersFactory") {
        groups = state.result.data["groups"];
        members = state.result.data["members"];
        currentUserMetaData = state.result.data["currentUserMetaData"];
      }

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
            physics: ClampingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverAppBarDelegate(
                            minHeight: minHeight,
                            maxHeight: maxHeight,
                            child: LayoutBuilder(
                              builder: (context, BoxConstraints constraints) {
                                double persentage =
                                    (constraints.maxHeight - 100) / 150;
                                double size = 40 + 90 * persentage;
                                double width =
                                    MediaQuery.of(context).size.width;

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
                                                bottom: Radius.elliptical(200,
                                                    20 + 30 * persentage))),
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
                                              leading:
                                                  WetonomyIconButton(IconButton(
                                                icon: Icon(
                                                  Icons.menu,
                                                  color: Colors.black54,
                                                ),
                                                onPressed: () =>
                                                    Scaffold.of(context)
                                                        .openDrawer(),
                                              )),
                                            )),
                                        Positioned(
                                          right: width / 2 - 52 * persentage,
                                          top: 43,
                                          child: Container(
                                              width: 105,
                                              child: Center(
                                                child: Text(
                                                  this.showGroup
                                                      ? "Groups"
                                                      : "Members",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                  (constraints.maxHeight > 230
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
                                                            {
                                                              this.switchView(
                                                                  true)
                                                            }
                                                          else
                                                            this.switchView(
                                                                false)
                                                        }),
                                                size: 40 + 20 * persentage,
                                              ),
                                            )),
                                        Positioned(
                                            top: 25,
                                            right: 66,
                                            child: Opacity(
                                              opacity:
                                                  (constraints.maxHeight > 150
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
                                                borderRadius:
                                                    BorderRadius.circular(
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
                            )))),
              ];
            },
            body: Container(
              padding: EdgeInsets.only(top: minHeight),
              child: ListView(
                children: <Widget>[...currentView],
              ),
            )),
      );
    });
  }
}
