import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/screens/voting/components/path_row.dart';

import '../dummy_data.dart';
import 'package:wetonomy/models/action.dart' as contract;

class ActionPath extends StatefulWidget {
  @override
  _ActionPath createState() => _ActionPath();
}

class _ActionPath extends State<ActionPath> {
  List<List<Node>> queue = [new List<Node>()];
  List<Widget> rows = [];
  int activePath = 0;

  void changeActivePath(int index){
    print(index);
    
    rows[activePath*2] = PathRow(queue[activePath], activePath, false, changeActivePath);
    activePath = index;
    rows[index*2] = PathRow(queue[index], index, true, changeActivePath);
    setState(() {});
  }

  _ActionPath() {
    var g = Node("Action", [
      Node("Central Voting", []),
      Node("Dev Group", [
        Node("Senior Group", [
          Node("Guest", []),
          Node("Marketing Group", [Node("42", [])])
        ]),
        Node("Manager Group", [])
      ]),
      Node("Gosho", [Node("Pesho", [])]),
    ]);
    _dfs(g, 0);

    int n = queue.length;

    for (int i = 0; i < n; i++) {
      List<Node> path = queue[i];
      rows.add(PathRow(path, i, false, changeActivePath));
      rows.add(
        Divider(
          color: Colors.grey.shade300,
          thickness: 0,
          height: 1,
        ),
      );
    }

    rows.removeLast();
  }
  

  _dfs(Node node, int current) {
    bool check = false;
    List<Node> sample = new List<Node>.from(queue[current]);

    node.neigs.forEach((x) => {
          if (check)
            {
              queue.add(new List<Node>.from(sample)),
              current = queue.length - 1
            },
          queue[current].add(node),
          if (!x.visited) {x.visited = true, _dfs(x, current)},
          check = true,
        });
    if (node.neigs.length == 0) queue[current].add(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Action Path Select',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              tooltip: 'Search',
              onPressed: () =>
                  {Navigator.of(context).popUntil((route) => route.isFirst)},
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Filters",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                  // Container(
                  //     height: 100,
                  //     width: 200,
                  //     child: TextField(

                  //   decoration: InputDecoration(
                  //       // fillColor: Colors.white,
                  //       // filled: true,
                  //       prefixIcon: Icon(Icons.search),
                  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  //       // labelText: "filters"
                  //       ),
                  // ),),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
              height: 1,
            ),
            Expanded(
                child: ListView(
              children: [
                ...rows,
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    margin: const EdgeInsets.only(top: 30),
                    child: RaisedButton(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Send Action",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => _sendActionAndNavigateBack(context),
                    )),
              ],
            )),
          ],
        ));
  }

  void _sendActionAndNavigateBack(BuildContext context) {
    TerminalInteractionBloc terminalInteractionBloc =
        BlocProvider.of<TerminalInteractionBloc>(context);
    terminalInteractionBloc.dispatch(ReceiveActionFromTerminalEvent(json));
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
