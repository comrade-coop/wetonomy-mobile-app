import 'dart:math';

import 'package:flutter/material.dart';

class Vertex extends StatelessWidget {
  final String index;
  final bool active;
  const Vertex(this.index, {this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 30,
        // width: 40,
        decoration: BoxDecoration(
          color: this.active ? Theme.of(context).primaryColor : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            index,
            style: TextStyle(
                color: this.active ? Colors.white : Colors.black54,
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}

class Edge extends StatelessWidget {
  final double size;
  
  final Color activeColor = Colors.orange;
  final bool active;
  const Edge(this.size, {this.active = false});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    double epsilon = 0;
    if (active) epsilon = 2;
    return Container(
        width: size,
        height: 30,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 11 - epsilon / 2,
                right: 0,
                child: //edge
                    Transform.rotate(
                  angle: pi / 5,
                  child: Container(
                      height: 2 + epsilon / 2,
                      width: 10 + epsilon,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: this.active ? activeColor : color,
                      )),
                )),
            Positioned(
              top: 14 - epsilon / 2,
              child: Container(
                  height: 2 + epsilon,
                  width: size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: this.active ? activeColor : color,
                  )),
            ),
            Positioned(
                right: 0,
                bottom: 11 - epsilon / 2,
                child: //edge
                    Transform.rotate(
                  angle: -pi / 5,
                  child: Container(
                      height: 2 + epsilon / 2,
                      width: 10 + epsilon,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: this.active ? activeColor : color,
                      )),
                ))
          ],
        ));
  }
}