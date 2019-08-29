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
  final TextEditingController _terminalUrlController = TextEditingController();
  String _error;

  static const String errorInvalidUrl = 'Input should be a valid Web URL.';
  static const String errorInvalidTerminal =
      'Input should be a URL pointing to a valid Wetonomy Terminal.';

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
            errorText: _error,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor)),
            errorMaxLines: 2),
        autocorrect: false,
        controller: _terminalUrlController,
      );

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildUrlInput(),
          _buildAddButton(),
        ],
      ),
    );
  }

  // TODO: Implement terminal validity checking
  bool _isValidTerminal(String url) {
    return true;
  }

  void _handleAddPressed() {
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

    _bloc.dispatch(AddTerminalEvent(TerminalData(s, [])));
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
