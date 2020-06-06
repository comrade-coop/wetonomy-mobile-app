import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_bloc.dart';
import 'package:wetonomy/screens/groups_members/members/members_detail.dart';
import 'package:wetonomy/screens/groups_members/models/member.dart';

class MemberSelectCard extends StatelessWidget {
  final bool isActive;
  final Member member;
  final Function setActive;
  final int index;

  const MemberSelectCard(this.member, this.isActive, this.setActive, this.index,
      {Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.transparent;
    Color background = Color.fromRGBO(236, 229, 244, 0.4);

    TextStyle titleTextStyle = TextStyle();
    TextStyle secondaryTextStyle = TextStyle(fontSize: 10);

    Widget _trailing = IconButton(
      icon: Icon(
        Icons.arrow_right,
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MemberDetails(member)));
      },
    );
    if (isActive) {
      _trailing = Container(
        height: 50,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.white, blurRadius: 2)],
          color: Colors.green,
        ),
        child: IconButton(
          icon: Icon(
            Icons.person_add,
            color: Colors.white,
          ),
          onPressed: () {_sendActionAndNavigateBack(context);} ,
        ),
      );

      borderColor = Theme.of(context).primaryColor;
      background = Color.fromRGBO(236, 229, 244, 1);
      secondaryTextStyle =
          TextStyle(fontSize: 10, color: Theme.of(context).primaryColorLight);
      titleTextStyle = TextStyle(color: Theme.of(context).primaryColor);
    }

    return Container(
        // height: 65,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1),
            color: background,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: ListTile(
            contentPadding: EdgeInsets.all(2),
            leading: memberIcon(member.iconAddress),
            title: Text(
              member.name,
              style: titleTextStyle,
            ),
            subtitle: Text(
              member.address,
              style: secondaryTextStyle,
            ),
            trailing: _trailing,
            onTap: () => setActive(index)));
  }

  Widget memberIcon(String icon) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      decoration: new BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.white, blurRadius: 2)],
          image: new DecorationImage(
              fit: BoxFit.fill, image: new NetworkImage(icon))),
      width: 50,
      height: 50,
    );
  }

  final String json = '''{
        "Targets": ["0x00000000000000000000"],
        "Type": "CreateAchievement",
        "Payload": {"Title": "test", "Description": "x"}
      }''';

  void _sendActionAndNavigateBack(BuildContext context) {
    TerminalInteractionBloc terminalInteractionBloc =
        BlocProvider.of<TerminalInteractionBloc>(context);
    terminalInteractionBloc.dispatch(ReceiveActionFromTerminalEvent(json));
    Navigator.pop(context);
  }
}
