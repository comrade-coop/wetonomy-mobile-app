import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/password_form_field.dart';

import 'accent_button.dart';

class PasswordForm extends StatefulWidget {
  final void Function(String) onSuccessfulValidation;

  const PasswordForm({Key key, @required this.onSuccessfulValidation})
      : assert(onSuccessfulValidation != null),
        super(key: key);

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  static const int minCharsPassword = 8;

  final _formKey = GlobalKey<FormState>();

  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            child: Center(child: _buildForm()),
          ),
        ),
        AccentButton(
            label: Strings.nextLabel,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                widget.onSuccessfulValidation(_password);
              }
            }),
      ],
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PasswordFormField(
              helperText: Strings.minCharsPassword(minCharsPassword),
              hintText: Strings.passwordLabel,
              validator: _validatePassword,
              onChanged: (String password) =>
                  setState(() => _password = password),
            ),
            SizedBox(height: 24),
            PasswordFormField(
              hintText: Strings.confirmPasswordLabel,
              validator: _validateRepeatedPassword,
              helperText: Strings.confirmPasswordLabel,
            ),
          ],
        ),
      ),
    );
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return Strings.emptyPasswordError;
    }

    if (value.length < minCharsPassword) {
      return Strings.minCharsPassword(minCharsPassword);
    }

    return null;
  }

  String _validateRepeatedPassword(String value) {
    if (_password != value) {
      return Strings.passwordsMatchError;
    }
    return null;
  }
}
