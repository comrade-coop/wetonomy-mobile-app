import 'package:flutter/material.dart';
import 'package:wetonomy/screens/welcome/components/logo_with_title_small.dart';

class WelcomeSectionScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const WelcomeSectionScaffold(
      {Key key, @required this.title, @required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        title: LogoWithTitleSmall(),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[_buildTitle(context), Expanded(child: body)],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.display1);
  }
}
