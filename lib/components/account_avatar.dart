import 'package:flutter/material.dart';

class AccountAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 8.0),
      child: CircleAvatar(
        backgroundColor: Colors.grey.withAlpha(50),
        child: Icon(
          Icons.person,
          size: 32,
          color: Colors.grey,
        ),
      ),
    );
  }
}
