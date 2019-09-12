import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
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
      providers: createBlocProviders(),
      child: MaterialApp(
        title: 'Wetonomy',
        theme: createPinkTheme(),
        routes: createRoutes(),
        // Needed in order for the native webview to know when to hide itself
        navigatorObservers: [WebviewAutoHideNavigatorObserver()],
      ),
    );
  }
}
