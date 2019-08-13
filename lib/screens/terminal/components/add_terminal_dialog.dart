import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart' as Validator;
import 'package:wetonomy/bloc/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager_event.dart';
import 'package:wetonomy/models/terminal_data.dart';

class AddTerminalDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<AddTerminalDialog> {
  final TextEditingController _terminalUrlController = TextEditingController();
  String _error;

  static const String errorInvalidUrl = 'Input should be a valid Web URL.';
  static const String errorInvalidTerminal =
      'Input should be a URL pointing to a valid Wetonomy Terminal.';

  @override
  void initState() {
    super.initState();
    _error = null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add a new Terminal'),
      content: _buildContent(),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(child: Text('Add'), onPressed: _handleAddPressed)
      ],
    );
  }

  void _handleAddPressed() {
    TerminalsManagerBloc bloc = BlocProvider.of<TerminalsManagerBloc>(context);
    String s = _terminalUrlController.text;

    if (!Validator.isURL(s)) {
      this.setState(() {
        _error = errorInvalidUrl;
      });
      return;
    }

    if (!_isValidTerminal(s)) {
      this.setState(() {
        _error = errorInvalidTerminal;
      });
      return;
    }

    bloc.dispatch(AddTerminalEvent(TerminalData(s, [])));
    Navigator.of(context).pop();
  }

  _buildUrlInput() => TextField(
        decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.all(8),
            labelText: 'Terminal URL',
            labelStyle: TextStyle(color: Colors.black54),
            errorText: _error,
            errorMaxLines: 2),
        autocorrect: false,
        controller: _terminalUrlController,
      );

  _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildUrlInput(),
      ],
    );
  }

  // TODO: Implement terminal validity checking
  bool _isValidTerminal(String url) {
    return true;
  }
}
