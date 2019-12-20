import 'package:flutter/material.dart';
import './vote_table.dart';



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
