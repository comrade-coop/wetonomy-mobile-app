import 'package:flutter/material.dart';
import 'package:myapp/vote_table.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Scaffold(
      //   appBar: AppBar(title: Text('Collapsing List Demo')),
      //   body: CollapsingList(),
      // ),
      home: VoteTable(),
    );
  }
}
