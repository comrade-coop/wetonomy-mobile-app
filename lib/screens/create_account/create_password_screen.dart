import 'package:flutter/material.dart';
import 'package:wetonomy/components/slide_right_transition.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/accent_button.dart';
import 'package:wetonomy/screens/create_account/view_mnemonic_screen.dart';

import 'components/create_account_scaffold.dart';

class CreatePasswordScreen extends StatefulWidget {
  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return CreateAccountScaffold(
      title: Strings.createPasswordLabel,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            child: Center(child: _buildPasswordInputs()),
          ),
        ),
        AccentButton(
          label: Strings.nextLabel,
          onPressed: () => Navigator.push(
              context, slideRightTransition(ViewMnemonicScreen())),
        )
      ],
    );
  }

  Widget _buildPasswordInputs() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildStyledTextField(
              helperText: Strings.minCharsPassword,
              hintText: Strings.passwordLabel),
          SizedBox(height: 24),
          _buildStyledTextField(hintText: Strings.confirmPasswordLabel),
        ],
      ),
    );
  }

  Widget _buildStyledTextField({String hintText, String helperText}) {
    return TextFormField(
        autocorrect: false,
        decoration: InputDecoration(
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            helperText: helperText,
            suffixIcon: Icon(Icons.remove_red_eye),
            hintText: hintText,
            alignLabelWithHint: true));
  }
}
