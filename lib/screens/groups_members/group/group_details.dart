import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/screens/groups_members/components/add_member.dart';
import 'package:wetonomy/screens/groups_members/components/permissions/permission_card.dart';
import 'package:wetonomy/screens/groups_members/components/permissions/permissions_count.dart';
import 'package:wetonomy/screens/groups_members/models/member.dart';
import 'package:wetonomy/screens/shared/sliver_appbar_delegate.dart';
import 'package:wetonomy/screens/shared/terminal_interaction.dart';
import 'package:wetonomy/screens/shared/wetonomy_app_bar.dart';
import 'package:wetonomy/screens/shared/wetonomy_icon_button.dart';

import '../models/group.dart';
import 'group_members.dart';
import 'horizontal_member_scroll.dart';

class GroupDetails extends StatefulWidget {
  final Group group;

  GroupDetails(this.group, {Key key}) : super(key: key);

  @override
  _GroupDetailsState createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> with TerminalInteraction {
  String currentUserAddress;

  //temporary
  Member currentUserMetaData;

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
    double minHeight = 160.0;
    double maxHeight = 380.0;

    super.snackBarColor = Theme.of(context).primaryColor;

    Member mockCurrentUser = currentUserMetaData;

    var permissions = List<PermissionCard>.generate(
        this.widget.group.permissions.length,
        (i) => PermissionCard(this.widget.group.permissions[i],
            this.widget.group.address, false));

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
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 25),
                                        child: WetonomyAppBar(
                                            "${widget.group.name} Group",
                                            mockCurrentUser),
                                      ),
                                      if (secondStep > 0.9)
                                        Positioned(
                                            top: 85,
                                            child: _description(width)),
                                      Positioned(
                                          top: 80 +
                                              65.0 * secondStep, //* persentage,
                                          child: _memberTale(
                                              secondStep, mockCurrentUser)),
                                      Opacity(
                                          opacity: persentage,
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 100 + 120 * persentage),
                                              child: HorizontalMemberScroll(
                                                  widget.group.members)))
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
                PermissionsCount(widget.group.permissions.length),
                ...permissions,
              ],
            ),
          ),
        ));
  }

  Widget _description(double width) {
    return Container(
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
    );
  }

  Widget _memberTale(double secondStep, Member mockCurrentUser) {
    return Row(children: <Widget>[
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      GroupMembers(this.widget.group, mockCurrentUser)));
        },
        child: Row(
          children: <Widget>[
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
                "Members count: ${widget.group.members.length}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
      Opacity(
        opacity: 0.5 + 0.5 * secondStep,
        child: WetonomyIconButton(
          IconButton(
              icon: Opacity(
                  opacity: 0.58,
                  child: Image.asset(
                    'assets/images/member_remove.png',
                  )),
              onPressed: () => this._showModalSheetAddMember()),
          size: 30 + 10 * secondStep,
        ),
      ),
      Opacity(
          opacity: 0.6 + 0.4 * secondStep,
          child: WetonomyIconButton(
            IconButton(
                icon: Icon(
                  Icons.person_add,
                  size: 16 + 8 * secondStep,
                  color: Colors.black54,
                ),
                onPressed: () => this._showModalSheetAddMember()),
            size: 30 + 10 * secondStep,
          ))
    ]);
  }

  void _showModalSheetAddMember() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (builder) {
          return AddMember(this.widget.group.members);
        });
  }

  void showModalSheetSharePermission() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (builder) {
          return Container(
            child: Text("Ketap"),
          );
        });
  }
}
