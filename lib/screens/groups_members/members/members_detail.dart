import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/screens/groups_members/components/permission_card.dart';
import 'package:wetonomy/screens/groups_members/components/permissions_count.dart';
import 'package:wetonomy/screens/groups_members/models/member.dart';
import 'package:wetonomy/screens/shared/sliver_appbar_delegate.dart';
import 'package:wetonomy/screens/shared/wetonomy_app_bar.dart';

import '../dummy_data.dart';
import 'horizontal_group_scroll.dart';

class MemberDetails extends StatefulWidget {
  final Member member;

  const MemberDetails(this.member, {Key key}) : super(key: key);

  @override
  _MemberDetailsState createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  String currentUserAddress;

  @override
  void initState() {
    super.initState();

    final accountsBlock = BlocProvider.of<AccountsBloc>(context);
    final AccountsState state = accountsBlock.currentState;
    if (state is LoggedInState) {
      this.currentUserAddress = state.wallet.address;
    }
  }

  @override
  Widget build(Object context) {
    Member mockCurrentUser = Member(
        currentUserMetaData.name,
        currentUserAddress,
        currentUserMetaData.iconAddress,
        currentUserMetaData.groups,
        currentUserMetaData.permissions);

    var permissions = List<PermissionCard>.generate(
        this.widget.member.permissions.length,
        (i) => PermissionCard(
            this.widget.member.permissions[i], this.widget.member.address));

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
            PermissionsCount(widget.member.permissions.length),
            ...permissions
          ],
        ),
      ),
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
