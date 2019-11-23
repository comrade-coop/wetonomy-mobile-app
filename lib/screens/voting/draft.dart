import 'package:flutter/material.dart';

import 'detailed_vote_box.dart';
import 'linear_percent_bar.dart';

class DraftWidget extends StatelessWidget {
  final todos = List.generate(
    5,
    (i) => VoteBoxWrapper(),
  );
  @override
  Widget build(BuildContext context) {
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
              child: Hero(tag: 'imageHero_$index', child: todos[index]),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailScreen(index);
                }));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}

class VoteBoxWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 19, 0, 0),
      elevation: 1,
      child: VoteBox(),
    );
  }
}

class VoteBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Container(
        //     // color: Colors.blue,
        //     margin: const EdgeInsets.only(top: 18),
        //     width: 150,
        //     padding: const EdgeInsets.symmetric(horizontal: 18),
        //     height: 25,
        //     decoration: BoxDecoration(
        //       color: Colors.blue,
        //       borderRadius: BorderRadius.all(Radius.circular(15)),
        //     ),
        //     child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text('Card Heading',
        //               style: TextStyle(
        //                   fontWeight: FontWeight.w500,
        //                   color: Colors.white,
        //                   fontSize: 16)),
        //           // Text('Ioan Stoianov',style: TextStyle(color: Colors.white))
        //         ])),
        // Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //   // Expanded(
        //   // child:

        //   // ),
        // ]),
        ListTile(
          leading: Icon(Icons.description),
          title: Text(
              'Change Comrade Cooperative\'s name to Stalin Cooperative, ',
              style: TextStyle(fontWeight: FontWeight.w400)),
          // subtitle: Text('Ioan Stoianov'),
        ),
        // _votesList(),
        Container(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: <Widget>[
                LinearPercentBar(46, Colors.green, 'Yes'),
                LinearPercentBar(54, Colors.red, 'No'),
              ],
            )),
      ],
    ));
  }
}
