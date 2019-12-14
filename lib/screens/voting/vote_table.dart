import 'package:flutter/material.dart';
import 'package:myapp/dummy_data.dart';
import 'package:myapp/new_vote.dart';
import 'package:myapp/vote_box.dart';

import 'detailed_vote_box.dart';

import 'dart:math';

class VoteTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var decisions = dummyDecisions;
    var rng = new Random();
    var todos = List.generate(
      decisions.length,
      (i) => VoteBoxWrapper(decisions[i]),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: Text('Decisions'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Hero(
                  transitionOnUserGestures: true,
                  tag: 'imageHero_$index',
                  child: todos[index]),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailScreen(index, decisions[index]);
                }));
              },
            );
          }),
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



