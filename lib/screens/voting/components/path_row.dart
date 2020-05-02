import 'package:flutter/material.dart';
import './vertex_edge.dart';
import '../dummy_data.dart';

class PathRow extends StatelessWidget {
//   final List<Node> path;
//   final Function callback;

//   PathRow(this.path, this.callback){
//     print(callback);
//   }
//   @override
//   _PathRow createState() => _PathRow(path, callback);
// }

// class _PathRow extends State<PathRow> {
  final List<Node> path;
  final int index;
  final Function(int) callback;
  
  final bool isActive;
  PathRow(this.path, this.index, this.isActive, this.callback){
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    print(callback);
    List<Widget> list = [];
    path.forEach((node) => {
          list.add(Vertex(
            node.value,
            active: isActive,
          )),
          list.add(Edge(
            30,
            active: isActive,
          ))
        });

    list.removeLast();

    return InkWell(
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: list,
        ),
      ),
      onTap: () {
        callback(index);
      },
    );
  }
}