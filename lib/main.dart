import 'package:flutter/material.dart';
import 'package:wetonomy/services/service_locator.dart';
import 'package:wetonomy/widgets/app.dart';

void main() async {
  setupLocator();
  runApp(MyApp());
}
