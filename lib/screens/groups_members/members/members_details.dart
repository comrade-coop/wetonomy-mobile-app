import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/screens/groups_members/components/permissions/permission_card.dart';
import 'package:wetonomy/screens/groups_members/components/permissions/permissions_count.dart';
import 'package:wetonomy/screens/groups_members/models/group.dart';
import 'package:wetonomy/screens/groups_members/models/member.dart';
import 'package:wetonomy/screens/shared/sliver_appbar_delegate.dart';
import 'package:wetonomy/screens/shared/terminal_interaction.dart';
import 'package:wetonomy/screens/shared/wetonomy_app_bar.dart';

import 'horizontal_group_scroll.dart';

class MemberDetails extends StatefulWidget {
  final Member member;

  final bool isPersonalPage;

  const MemberDetails(this.member, {this.isPersonalPage = false, key})
      : super(key: key);

  @override
  _MemberDetailsState createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> with TerminalInteraction {
  String currentUserAddress;
  Member currentUserMetaData;
  List<Group> groups = [];
  
  @override
  void initState() {
    super.initState();

    final AccountsState state = BlocProvider.of<AccountsBloc>(context).state;
    if (state is LoggedInState) {
      this.currentUserAddress = state.wallet.address;
    }

    super.terminalInteractionBloc =
        BlocProvider.of<TerminalInteractionBloc>(context);

    super.terminalInteractionBlocSubscription =
        super.terminalInteractionBloc.listen(_handleTerminalStateChange);
  }

  void _handleTerminalStateChange(TerminalInteractionState state) {
    if (state is ReceiveActionFromTerminalState) {
      showSnackBar("Sending Action", snackBarColor);
    }
    if(state is ReceivedQueryResultState && state.result.query.contractAddress == "GroupsAndMembersFactory"){
      groups = state.result.data["groups"];
      currentUserMetaData = state.result.data["currentUserMetaData"];
    }
    // else if (state is ...) {}
  }

  @override
  void dispose() {
    super.terminalInteractionBlocSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(Object context) {
    double minHeight = 260.0;
    double maxHeight = 440.0;

    List<Group> memberGroups = groups.where((element) => this.widget.member.groups.contains(element.name)).toList();

    super.snackBarColor = Theme.of(context).primaryColor;

    Member mockCurrentUser = currentUserMetaData;

    var permissions = List<PermissionCard>.generate(
        this.widget.member.permissions.length,
        (i) => PermissionCard(this.widget.member.permissions[i],
            this.widget.member.address, this.widget.isPersonalPage));

    return Scaffold(
      key: super.scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(236, 236, 236, 1),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverAppBarDelegate(
                          minHeight: minHeight,
                          maxHeight: maxHeight,
                          child: LayoutBuilder(
                            builder: (context, BoxConstraints constraints) {
                              double persentage =
                                  (constraints.maxHeight - 260) / 180;
                              // print(persentage);
                              double width = MediaQuery.of(context).size.width;

                              return Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment(1.0, 2),
                                        colors: <Color>[
                                          Theme.of(context).primaryColor,
                                          Theme.of(context).accentColor,
                                        ]),
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(20)),
                                  ),
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(top: 25),
                                          child: WetonomyAppBar(
                                            "",
                                            mockCurrentUser,
                                            showAvatar: false,
                                          )),
                                      Positioned(
                                          width: width,
                                          height: 205,
                                          top: 40,
                                          child: _personalDetails()),
                                      Positioned(
                                          width: width,
                                          top: 127 + 130 * persentage,
                                          child: Opacity(
                                            opacity: persentage,
                                            child: _groupsCount(),
                                          )),
                                      Opacity(
                                          opacity: persentage,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 160 + 100 * persentage),
                                            // margin: EdgeInsets.only(bottom: 20),
                                            child:
                                                HorizontalGroupScroll(memberGroups),
                                          ))
                                    ],
                                  ));
                            },
                          )))),
            ];
          },
          body: Container(
            padding: EdgeInsets.only(top: minHeight),
            child: ListView(
              children: <Widget>[
                PermissionsCount(widget.member.permissions.length),
                ...permissions
              ],
            ),
          )),
    );
  }

  Widget _groupsCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 12),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Text("Groups",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(118, 55, 245, 1),
                // fontSize: 18.0,
              )),
        ),
        Container(
          margin: EdgeInsets.only(right: 12),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.people,
                    color: Color.fromRGBO(118, 55, 245, 1),
                    size: 18,
                  )),
              Text(widget.member.groups.length.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(118, 55, 245, 1),
                    // fontSize: 18.0,
                  )),
            ],
          ),
        )
      ],
    );
  }

  Widget _personalDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Developer",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
        ),
        Container(
          width: 105,
          height: 105,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white, width: 1),
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
                borderRadius: BorderRadius.circular(30),
                child: Image.network(widget.member.iconAddress,
                    scale: 1.5, fit: BoxFit.fill),
              )),
        ),
        Text(
          this.widget.member.name,
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              shadows: [Shadow(blurRadius: 2, color: Colors.white)]),
        ),
        Text(this.widget.member.address,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            )),
      ],
    );
  }
}
