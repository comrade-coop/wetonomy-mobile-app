import 'package:flutter/material.dart';
import 'package:wetonomy/app.dart';
import 'package:wetonomy/services/service_locator.dart';

void main() async {
  await setupServiceLocator();
  runApp(WetonomyApp());
}
