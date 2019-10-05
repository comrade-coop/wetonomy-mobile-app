import 'package:flutter/material.dart';
import 'package:wetonomy/screens/create_account/components/logo_with_title_small.dart';

class CreateAccountScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const CreateAccountScaffold(
      {Key key, @required this.title, @required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: LogoWithTitleSmall(),
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTitle(context),
          SizedBox(
            height: 32,
          ),
          Expanded(
              child: ConstrainedBox(
            child: body,
            constraints: BoxConstraints(maxWidth: 700),
          ))
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(title,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline
            .apply(fontFamily: 'Montserrat', fontWeightDelta: 2));
  }
}
