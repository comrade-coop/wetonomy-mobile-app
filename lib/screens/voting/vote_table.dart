import 'package:flutter/material.dart';
import './add_decission/new_vote.dart';
import './dummy_data.dart';
import './vote_box.dart';

import 'detailed_vote_box.dart';

class VoteTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var decisions = dummyDecisions;
    var decisionsList = List.generate(
        decisions.length,
        (index) => GestureDetector(
              child: Hero(
                  transitionOnUserGestures: true,
                  tag: 'imageHero_$index',
                  child: VoteBoxWrapper(decisions[index])),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailScreen(index, decisions[index]);
                }));
              },
            ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: Text('Decisions',style: TextStyle(color: Colors.black54),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ...decisionsList,
          Container(
            padding: const EdgeInsets.only(bottom: 20),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return NewVote();
          }));
        },
      ),
    );
  }
}
