import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/welcome/components/logo_with_title_small.dart';
import 'package:wetonomy/screens/welcome/components/accent_text_button.dart';

import 'welcome_section_scaffold.dart';

class CreatePasswordSection extends StatefulWidget {
  @override
  _CreatePasswordSectionState createState() => _CreatePasswordSectionState();
}

class _CreatePasswordSectionState extends State<CreatePasswordSection> {
  @override
  Widget build(BuildContext context) {
    return WelcomeSectionScaffold(
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
        AccentTextButton(
          label: Strings.nextLabel,
          onPressed: () {},
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
