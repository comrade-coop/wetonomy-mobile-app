import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  final String Function(String) validator;
  final Function(String) onChanged;
  final String helperText;
  final String labelText;
  final TextInputAction inputAction;
  final ValueChanged<String> onFieldSubmitted;
  final FocusNode focusNode;
  final bool autoValidate;

  const PasswordFormField(
      {Key key,
      this.validator,
      this.onChanged,
      this.helperText,
      this.labelText,
      this.inputAction,
      this.onFieldSubmitted,
      this.focusNode,
      this.autoValidate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: this.focusNode,
        validator: validator,
        onChanged: onChanged,
        textInputAction: inputAction,
        autocorrect: false,
        autovalidate: autoValidate,
        obscureText: true,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withAlpha(20))),
            focusColor: Theme.of(context).accentColor,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor)),
            helperText: helperText,
            labelStyle: Theme.of(context).textTheme.body1,
            labelText: labelText,
            alignLabelWithHint: true));
  }
}
