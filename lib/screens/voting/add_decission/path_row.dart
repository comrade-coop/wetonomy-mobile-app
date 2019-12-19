import 'package:flutter/material.dart';
import 'package:myapp/add_decission/vertex_edge.dart';
import 'package:myapp/dummy_data.dart';

class PathRow extends StatefulWidget {
  final List<Node> path;

  const PathRow(this.path);
  @override
  _PathRow createState() => _PathRow(path);
}

class _PathRow extends State<PathRow> {
  final List<Node> path;
  bool isActive = false;
  _PathRow(this.path);

  @override
  Widget build(BuildContext context) {
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
      onTap: () => {
        isActive = !isActive,
        setState(() {}),
      },
    );
  }
}