import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_bloc.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_event.dart';
import './models/decision.dart';
import './vote_box.dart';
import './votes_list.dart';
import 'package:wetonomy/models/action.dart' as contract;

import 'dummy_data.dart';

class DetailScreen extends StatelessWidget {
  final int index;
  final Decision decision;
  final String currentUserAddress;
  DetailScreen(this.index, this.decision, this.currentUserAddress);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          // title: Text('Vote №1', style: TextStyle(color: Colors.black),),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              tooltip: 'Search',
              onPressed: null,
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 6),
          child: Center(
            child: Hero(
              tag: 'imageHero_$index',
              child: Material(
                  child: Column(
                children: <Widget>[
                  VoteBox(decision, inCard: false),
                  _extendedInfo(context),
                  _buttonBar(context),
                  
                ],
              )),
            ),
          ),
        ));
  }

  Widget _extendedInfo(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          child: ListTile(
            leading: Icon(Icons.supervisor_account),
            title: Text('${decision.votes.length} votes',
                style: TextStyle(fontWeight: FontWeight.w400)),
            trailing: Icon(Icons.more_horiz),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return VotesList(decision);
              }));
            },
          ),
        ),
        ListTile(
          leading: Icon(Icons.access_time),
          title: Text("Time Left"),
          trailing: Text("2d 12h 47m"),
        ),
      ],
    );
  }

  Widget _buttonBar(BuildContext context) {
    TerminalInteractionBloc terminalInteractionBloc =
        BlocProvider.of<TerminalInteractionBloc>(context);
    var x = decision.votes.indexWhere((x) => x.address == currentUserAddress);
    if (x < 0) {
      return ExpansionTile(
        leading: Icon(Icons.send),
        title: Text("Submit your vote",
            style: TextStyle(fontWeight: FontWeight.w400)),
        initiallyExpanded: false,
        children: <Widget>[
          ButtonBar(
            // mainAxisSize: MainAxisSize.min,
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: 160,
                child: RaisedButton(
                  elevation: 4,
                  color: Colors.green,
                  child: Text('Yes', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    terminalInteractionBloc.dispatch(ReceiveActionFromTerminalEvent(json));
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: 160,
                child: RaisedButton(
                  elevation: 4,
                  color: Colors.red,
                  child: Text('No', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    terminalInteractionBloc.dispatch(ReceiveActionFromTerminalEvent(json));
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        ],
      );
    } else {
      Map<String, IconData> icons = {"yes": Icons.check, "no": Icons.close};
      Map<String, Color> colors = {"yes": Colors.green, "no": Colors.red};
      String vote = decision.votes[x].vote;
      return ListTile(
        leading: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
              color: icons[vote] == null ? Colors.grey.shade50 : colors[vote],
              borderRadius: BorderRadius.circular(30)),
          child: icons[vote] != null
              ? Icon(
                  icons[vote],
                  size: 18,
                  color: Colors.white,
                )
              : Container(),
        ),
        title: Text("Your vote is ${decision.votes[x].vote}",
            style: TextStyle(fontWeight: FontWeight.w400)),
      );
    }
  }
}