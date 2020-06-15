import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/screens/groups_members/components/add_member.dart';
import 'package:wetonomy/screens/groups_members/components/permissions/shared_permission.dart';
import 'package:wetonomy/screens/groups_members/models/group.dart';
import 'package:wetonomy/screens/groups_members/models/member.dart';
import 'package:wetonomy/screens/groups_members/models/permission.dart';

import 'package:wetonomy/screens/shared/show_modal.dart';
import 'package:wetonomy/screens/shared/terminal_interaction.dart';

class PermissionTile extends StatefulWidget {
  final Permission perm;
  final bool isPersonalPage;
  final String currentDelegateAddress;

  const PermissionTile(
      this.perm, this.isPersonalPage, this.currentDelegateAddress,
      {Key key})
      : super(key: key);
  @override
  _PermissionTileState createState() => _PermissionTileState();
}

class _PermissionTileState extends State<PermissionTile> with ShowModal, TerminalInteraction {
  int activeIndex = -1;

  List<Group> groups = [];
  List<Member> members = [];
  Member currentUserMetaData;

  @override
  void initState() {
    super.initState();

    super.terminalInteractionBloc =
        BlocProvider.of<TerminalInteractionBloc>(context);

    // super.terminalInteractionBlocSubscription =
    //     terminalInteractionBloc.state.listen(_handleTerminalStateChange);

    super.terminalInteractionBloc.add(ReceiveQueryFromTerminalEvent(Query("GroupsAndMembersFactory")));
  }
  

  void _handleTerminalStateChange(TerminalInteractionState state) {
    if (state is ReceiveActionFromTerminalState) {
      showSnackBar("Sending Action", snackBarColor);
    }
    if(state is ReceivedQueryResultState && state.result.query.contractAddress == "GroupsAndMembersFactory"){
      groups = state.result.data["groups"];
      members = state.result.data["members"];
      currentUserMetaData = state.result.data["currentUserMetaData"];
    }
    // else if (state is ...) {}
  }

  @override
  void dispose() {
    super.terminalInteractionBlocSubscription?.cancel();
    super.dispose();
  }

  void setActive(int index) {
    this.setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _leading = Icon(
      Icons.code,
      size: 24,
      color: Color.fromRGBO(118, 55, 245, 1),
    );
    Widget _title = Text(this.widget.perm.permissionsLabel,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(118, 55, 245, 1),
          fontSize: 16.0,
        ));

    if (this.widget.perm.ownerAddress == widget.currentDelegateAddress &&
        this.widget.perm.sharedTo.length > 0) {
      return ExpansionTile(
        leading: _leading,
        title: _title,
        children: <Widget>[
          sharedTo(),
          ...generateShareList(context, this.widget.perm.sharedTo),
          if (this.widget.isPersonalPage) shareButton()
        ],
        onExpansionChanged: (check) => {this.setActive(-1)},
      );
    } else {
      Widget _trailing = Text("");
      if (!this.widget.isPersonalPage &&
          this.widget.perm.ownerAddress == this.currentUserMetaData.address) {
        _trailing = IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () => super.showModalSheetConfirmation(context));
      }
      if (this.widget.perm.ownerAddress != this.widget.currentDelegateAddress) {
        return sharedTile(_leading, _title, _trailing);
      }

      return ListTile(
        leading: _leading,
        title: _title,
        trailing: _trailing,
      );
    }
  }

  List<Widget> generateShareList(BuildContext context, List<String> names) {
    if (names == null) return [];
    return List.generate(
        names.length,
        (index) => SharedPermission(names[index], setActive,
            activeIndex == index, index, this.widget.isPersonalPage));
  }

  Widget sharedTile(Widget _leading, Widget _title, Widget _trailing) {
    // TODO create dynamic Name fetch
    String result = 'Unknown';
    var m = members
        .where((mem) => mem.address == this.widget.perm.ownerAddress)
        .toList();
    if (m.length == 0) {
      var g = groups
          .where((group) => group.address == this.widget.perm.ownerAddress)
          .toList();
      result = "${g[0].name} Group";
    } else {
      result = m[0].name;
    }

    return ListTile(
      leading: _leading,
      title: _title,
      subtitle: Text(
        "Shared from $result",
        style: TextStyle(fontSize: 10),
      ),
      trailing: _trailing,
    );
  }

  Widget sharedTo() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 18),
        // alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.share,
              size: 16,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              "   Shared to",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ));
  }

  Widget shareButton() {
    return FlatButton(
      onPressed: () => this.showModalSheetSharePermission(context),
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        margin: EdgeInsets.symmetric(horizontal: 18),
        // alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.person_add,
              size: 16,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              "   Share",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showModalSheetSharePermission(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (builder) {
          return AddMember([currentUserMetaData]);
        });
  }
}
