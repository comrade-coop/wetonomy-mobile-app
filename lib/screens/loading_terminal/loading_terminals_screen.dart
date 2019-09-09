import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wetonomy/screens/terminal/components/terminal_app_bar.dart';
import 'package:wetonomy/screens/terminal/components/terminal_drawer.dart';

class LoadingTerminalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StackDrawerScaffold(
      appBar: buildTerminalAppBar(),
      body: Center(child: CircularProgressIndicator()),
      drawer: AppDrawer(),
    );
  }
}
