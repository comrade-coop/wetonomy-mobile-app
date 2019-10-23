import 'package:flutter/material.dart';
import 'package:wetonomy/components/password_form_field.dart';
import 'package:wetonomy/screens/create_account/components/accent_button.dart';

class PasswordForm extends StatefulWidget {
  final VoidCallback onSuccessfulValidation;

  const PasswordForm({Key key, this.onSuccessfulValidation}) : super(key: key);

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[_buildForm(), _buildSignInBtn()],
      ),
    );
  }

  Widget _buildSignInBtn() {
    return AccentButton(
      label: 'Sign in',
      onPressed: () {
        widget.onSuccessfulValidation ?? widget.onSuccessfulValidation();
      },
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: PasswordFormField(),
    );
  }
}
