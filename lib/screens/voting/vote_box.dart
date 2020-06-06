import 'package:flutter/material.dart';

import './linear_percent_bar.dart';
import './models/decision.dart';

class VoteBox extends StatelessWidget {
  final Decision decision;
  final bool inCard;
  VoteBox(this.decision,{this.inCard = true});

  @override
  Widget build(BuildContext context) {
    double percentage = num.parse(
        (decision.positiveVotesCount / decision.votes.length * 100)
            .toStringAsFixed(1));
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: Image.asset('assets/images/vote-yes.png',scale: 1.2,),
          title: Text(decision.heading,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
        ),
        
        Container(
            // padding: const EdgeInsets.only(bottom: 1),
            child: Column(
              children: <Widget>[
                LinearPercentBar(percentage, inCard: inCard),
                // LinearPercentBar(100 - percentage, Colors.red, 'No'),
              ],
            )),
      ],
    ));
  }
}

class VoteBoxWrapper extends StatelessWidget {
  final Decision decision;

  VoteBoxWrapper(this.decision);
  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  offset: Offset.fromDirection(2.0),
                  color: Colors.black54)
            ]),
      //     child: Card(
      // // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      // elevation: 0,
      child: VoteBox(decision),
    );
  }
}
