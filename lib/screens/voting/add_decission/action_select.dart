import 'package:flutter/material.dart';
import '../models/contract.dart';

import 'dynamic_action_form.dart';

class ActionSelect extends StatelessWidget {
  final Contract contract;

  ActionSelect(this.contract);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Action Select',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              tooltip: 'Search',
              onPressed: ()=>{
                Navigator.of(context).popUntil((route) => route.isFirst)
              },
            ),
          ],
        ),
        body: Column(children: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: 
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: <Widget>[
                    //     Container(
                    //       margin: const EdgeInsets.only(right: 12),
                    //       child: Icon(
                    //         Icons.hdr_strong,
                    //         color: Theme.of(context).accentColor,
                    //       ),
                    //     ),
                    //     Text(contract.name,
                    //         style: TextStyle(fontSize: 18, color: Theme.of(context).accentColor,)),
                    //   ],
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(vertical: 10),
                    //   child: Text(contract.address,
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         color: Colors.black54
                    //       )),
                    // ),

                  ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Icon(
                  Icons.hdr_strong,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  contract.name,
                  style: TextStyle(fontSize: 18)
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text("${contract.address}",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),




                  ])),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey.shade300))),
            child: ListView(
              children: _generateActionsList(context),
            ),
          ))
        ]));
  }
  List<Widget> _generateActionsList(BuildContext context){
    return List.generate(
      contract.actions.length,
      (index) => ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        leading: Icon(
          Icons.code,
          color: Theme.of(context).accentColor,
        ),
        title: Text(contract.actions[index].name),
        onTap: () => {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DynamicActionForm(contract, contract.actions[index]);
          }))
        },
      ),
    );
  }
}
