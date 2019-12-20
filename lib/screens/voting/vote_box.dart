import 'package:flutter/material.dart';
import './batch.dart';
import './linear_percent_bar.dart';
import './models/decision.dart';

class VoteBox extends StatelessWidget {
  final Decision decision;
  VoteBox(this.decision);

  @override
  Widget build(BuildContext context) {
    double percentage = num.parse((decision.positiveVotesCount / decision.votes.length*100).toStringAsFixed(1));
    return Material(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.description),
          title: Text(
              decision.heading,
              style: TextStyle(fontWeight: FontWeight.w400)),
        ),
        Container(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: <Widget>[
                LinearPercentBar(percentage),
                // LinearPercentBar(100 - percentage, Colors.red, 'No'),
              ],
            )),
      ],
    ));
  }
}

class VoteBoxWrapper extends StatelessWidget {
  final Decision decision;
  final List<Color> batchColors = [
    // Colors.blue.shade400,
    Colors.purple.shade400,
    Colors.orange.shade400,
    // Colors.pink.shade400,
  ];
  VoteBoxWrapper(this.decision);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 4),
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              decision.batches.length, 
              (index) => Batch(decision.batches[index],batchColors[index%batchColors.length]),
              )
          ),
        ),

        Card(
          margin: const EdgeInsets.only(top: 3),
          elevation: 3,
          child: VoteBox(decision),
        )
      ],
    );
  }
}
