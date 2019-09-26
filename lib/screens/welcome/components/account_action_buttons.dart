import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';

class AccountActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildCreateAccountButton(context),
          SizedBox(height: 16),
          _buildImportButton(context)
        ],
      ),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return _buildButton(
        label: Strings.createAccountLabel,
        color: Theme.of(context).primaryColor,
        textColor: Theme.of(context).accentColor,
        onPressed: () {});
  }

  Widget _buildImportButton(BuildContext context) {
    return _buildButton(
        label: Strings.importAccountLabel,
        color: Colors.black.withAlpha(30),
        onPressed: () {});
  }

  Widget _buildButton(
      {String label, Color color, Color textColor, VoidCallback onPressed}) {
    return FlatButton(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          label,
          style: TextStyle(color: textColor, fontFamily: 'Montserrat'),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
