import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './models/decision.dart';
import './vote_box.dart';
import './votes_list.dart';

class DetailScreen extends StatelessWidget {
  final int index;
  final Decision decision;
  DetailScreen(this.index, this.decision);

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
                  VoteBox(decision),
                  _extendedInfo(context),
                  _buttonBar()
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
            title:
                Text('${decision.votes.length} votes', style: TextStyle(fontWeight: FontWeight.w400)),
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

  Widget _buttonBar() {
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
              print('Ketap');
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
              print('Ketap');
            },
          ),
        ),
          ],
        )
      ],
    );
  }
}
