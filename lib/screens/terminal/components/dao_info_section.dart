import 'package:flutter/material.dart';

class DaoInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 28,
            ),
            Text(
              'Comrade Coop',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Row(children: <Widget>[
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: Colors.greenAccent.shade700, shape: BoxShape.circle),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Connected to Node',
                style: TextStyle(color: Colors.greenAccent.shade700),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
