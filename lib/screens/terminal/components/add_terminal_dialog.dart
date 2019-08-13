import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager_bloc.dart';
import 'package:wetonomy/bloc/terminals_manager_event.dart';
import 'package:wetonomy/models/terminal_data.dart';

class AddTerminalDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<AddTerminalDialog> {
  final TextEditingController _terminalUrlController = TextEditingController();
  TerminalsManagerBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<TerminalsManagerBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add a new Terminal'),
      content: TextField(
        controller: _terminalUrlController,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('Add'),
          onPressed: () {
            String s = _terminalUrlController.text;
            Navigator.of(context).pop();
            print(s);

            _bloc.dispatch(AddTerminalEvent(TerminalData(s, [])));
          },
        )
      ],
    );
  }
}
