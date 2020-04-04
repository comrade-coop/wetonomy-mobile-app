import 'package:flutter/material.dart';
import 'package:wetonomy/screens/create_account/components/create_account_scaffold.dart';

class LoadingScreen extends StatelessWidget {
  final String title;

  const LoadingScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CreateAccountScaffold(
        title: title, body: Center(child: CircularProgressIndicator()));
  }
}
