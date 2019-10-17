import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  final String Function(String) validator;
  final Function(String) onChanged;
  final String helperText;
  final String hintText;
  final TextInputAction inputAction;
  final ValueChanged<String> onFieldSubmitted;
  final FocusNode focusNode;
  final bool autovalidate;

  const PasswordFormField(
      {Key key,
      this.validator,
      this.onChanged,
      this.helperText,
      this.hintText,
      this.inputAction,
      this.onFieldSubmitted,
      this.focusNode,
      this.autovalidate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: this.focusNode,
        validator: validator,
        // onChanged: onChanged,
        textInputAction: this.inputAction,
        autocorrect: false,
        autovalidate: autovalidate,
        obscureText: true,
        onFieldSubmitted: this.onFieldSubmitted,
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
