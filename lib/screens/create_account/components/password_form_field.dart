import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  final String Function(String) validator;
  final Function(String) onChanged;
  final String helperText;
  final String hintText;

  const PasswordFormField(
      {Key key, this.validator, this.onChanged, this.helperText, this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        onChanged: onChanged,
        autocorrect: false,
        obscureText: true,
        decoration: InputDecoration(
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            helperText: helperText,
            hintText: hintText,
            alignLabelWithHint: true));
  }
}
