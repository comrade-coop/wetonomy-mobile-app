import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart' as Validator;
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager/terminals_manager_event.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/components/colored_shadow_raised_button.dart';

class AddNewTerminalSection extends StatefulWidget {
  @override
  _AddNewTerminalSectionState createState() => _AddNewTerminalSectionState();
}

class _AddNewTerminalSectionState extends State<AddNewTerminalSection> {
  String _urlError;
  String _nameError;

  String _terminalUrl;
  String _terminalName;

  static const String errorInvalidUrl =
      'Terminal URL should be a valid Web URL.';
  static const String errorInvalidTerminal =
      'Terminal URL should be pointing to a valid Wetonomy Terminal.';
  static const String errorInvalidName = 'Terminal Name is invalid';

  TerminalsManagerBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<TerminalsManagerBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: _buildContent(),
    );
  }

  Widget _buildUrlInput() => TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            labelText: 'Terminal URL',
            border: OutlineInputBorder(),
            labelStyle: TextStyle(color: Colors.black54),
            errorText: _urlError,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor)),
            errorMaxLines: 2),
        autocorrect: false,
        onChanged: (String text) {
          setState(() {
            _terminalUrl = text;
          });
          _checkValidTerminal(text);
        },
      );

  Widget _buildNameInput() => TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            labelText: 'Terminal Name',
            border: OutlineInputBorder(),
            labelStyle: TextStyle(color: Colors.black54),
            errorText: _nameError,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor)),
            errorMaxLines: 2),
        autocorrect: false,
        onChanged: (String text) {
          setState(() {
            _terminalName = text;
          });
          _checkValidName(text);
        },
      );

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildUrlInput(),
              SizedBox(
                height: 16,
              ),
              _buildNameInput()
            ],
          ),
          _buildAddButton(),
        ],
      ),
    );
  }

  // TODO: Implement terminal url validity checking
  bool _checkValidTerminal(String url) {
    if (!Validator.isURL(url)) {
      setState(() {
        _urlError = errorInvalidUrl;
      });
      return false;
    }

    setState(() {
      _urlError = null;
    });

    return true;
  }

  // TODO: Implement terminal name validity checking
  bool _checkValidName(String name) {
    if (name == null || name.isEmpty) {
      return false;
    }

    return true;
  }

  void _handleAddPressed() {
    if (!_checkValidTerminal(_terminalUrl) || !_checkValidName(_terminalName)) {
      return;
    }

    _bloc.add(AddTerminalsManagerEvent(TerminalData(_terminalUrl, _terminalName)));
    Navigator.of(context).pop();
  }

  Widget _buildAddButton() {
    return ColoredShadowRaisedButton(
      padding: EdgeInsets.all(16),
      child: Text(
        'Add Terminal',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      color: Theme.of(context).accentColor,
      onPressed: _handleAddPressed,
      shadowColor: Theme.of(context).accentColor.withAlpha(150),
    );
  }
}
