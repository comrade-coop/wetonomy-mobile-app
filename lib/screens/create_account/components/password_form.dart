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
  final _passwordNode = FocusNode();
  final _repeatPasswordNode = FocusNode();
  bool _autovalidate = false;

  String _password;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildForm(),
          AccentButton(
              label: Strings.nextLabel,
              onPressed: () {
                if (_validateInputs()) {
                  widget.onSuccessfulValidation(_password);
                }
              }),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PasswordFormField(
            focusNode: _passwordNode,
            helperText: Strings.minCharsPassword(minCharsPassword),
            hintText: Strings.passwordLabel,
            inputAction: TextInputAction.next,
            validator: _validatePassword,
            autovalidate: _autovalidate,
            onChanged: (String password) =>
                setState(() => _password = password),
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_repeatPasswordNode);
            },
          ),
          SizedBox(height: 24),
          PasswordFormField(
            focusNode: _repeatPasswordNode,
            hintText: Strings.confirmPasswordLabel,
            validator: _validateRepeatedPassword,
            autovalidate: _autovalidate,
            helperText: Strings.confirmPasswordLabel,
          ),
        ],
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

  bool _validateInputs() {
    if (!_autovalidate) {
      setState(() {
        _autovalidate = true;
      });
    }
    return _formKey.currentState.validate();
  }
}
