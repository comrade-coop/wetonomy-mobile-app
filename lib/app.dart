import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/bloc/app_bloc_providers.dart';
import 'package:wetonomy/routes.dart';
import 'package:wetonomy/themes.dart';

class WetonomyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: createBlocProviders(),
      child: MaterialApp(
        title: 'Wetonomy',
        theme: createPinkTheme(),
        routes: createRoutes(),
        // Needed in order for the native webView to know when to hide itself
        navigatorObservers: [WebviewAutoHideNavigatorObserver()],
      ),
    );
  }
}
