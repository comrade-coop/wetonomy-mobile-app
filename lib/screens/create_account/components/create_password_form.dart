import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/components/password_form_field.dart';

import 'accent_button.dart';

class CreatePasswordForm extends StatefulWidget {
  final void Function(String) onSuccessfulValidation;

  const CreatePasswordForm({Key key, @required this.onSuccessfulValidation})
      : assert(onSuccessfulValidation != null),
        super(key: key);

  @override
  _CreatePasswordFormState createState() => _CreatePasswordFormState();
}

class _CreatePasswordFormState extends State<CreatePasswordForm> {
  static const int minCharsPassword = 8;

  final _formKey = GlobalKey<FormState>();
  final _passwordNode = FocusNode();
  final _repeatPasswordNode = FocusNode();
  bool _autoValidate = false;

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
            labelText: Strings.passwordLabel,
            inputAction: TextInputAction.next,
            validator: _validatePassword,
            autoValidate: _autoValidate,
            onChanged: (String password) =>
                setState(() => _password = password),
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_repeatPasswordNode);
            },
          ),
          SizedBox(height: 24),
          PasswordFormField(
            focusNode: _repeatPasswordNode,
            labelText: Strings.confirmPasswordLabel,
            validator: _validateRepeatedPassword,
            autoValidate: _autoValidate,
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
    if (!_autoValidate) {
      setState(() {
        _autoValidate = true;
      });
    }
    return _formKey.currentState.validate();
  }
}
