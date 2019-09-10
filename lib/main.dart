import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/app_bloc_providers.dart';
import 'package:wetonomy/routes.dart';
import 'package:wetonomy/services/service_locator.dart';
import 'package:wetonomy/themes.dart';

void main() async {
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        title: 'Wetonomy',
        theme: defaultTheme,
        routes: routes,
      ),
    );
  }
}
