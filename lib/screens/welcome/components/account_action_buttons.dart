import 'package:flutter/material.dart';
import 'package:wetonomy/components/slide_right_transition.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/create_account_screen.dart';
import 'package:wetonomy/screens/import_account/import_account_screen.dart';

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
      onPressed: () => Navigator.push(
        context,
        slideRightTransition(CreateAccountScreen()),
      ),
    );
  }

  Widget _buildImportButton(BuildContext context) {
    return _buildButton(
      label: Strings.importAccountLabel,
      color: Colors.black.withAlpha(30),
      textColor: Colors.white,
      onPressed: () => Navigator.push(
        context,
        slideRightTransition(ImportAccountScreen()),
      ),
    );
  }

  Widget _buildButton(
      {String label, Color color, Color textColor, VoidCallback onPressed}) {
    return FlatButton(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
