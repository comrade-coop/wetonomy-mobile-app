import 'package:flutter/material.dart';
import 'package:wetonomy/widgets/main_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wetonomy',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white
      ),
      home: MainPage(),
    );
  }
}
