import 'package:flutter/material.dart';
import 'package:myapp/votes_list.dart';
import 'draft.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(child: DraftWidget(),)
      
    );
  }
}
