import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';

class SharedPermission extends StatelessWidget {
  final String name;

  final Function setActive;

  final bool isActive;

  final int index;

  const SharedPermission(this.name, this.setActive, this.isActive, this.index,
      {Key key})
      : super(key: key);

  @override
  Widget build(Object context) {
    Widget _trailing = Text("");
    if (this.isActive)
      _trailing = IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => _showModalSheetAddMember(
              context) // _sendActionAndNavigateBack(context),
          );
    return Material(
        color: Colors.white,
        child: ListTile(
          leading: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
                size: 22,
              )),
          title: Text(
            this.name,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          trailing: _trailing,
          onTap: () => setActive(index),
        ));
  }

  final String json = '''{
        "Targets": ["0x00000000000000000000"],
        "Type": "CreateAchievement",
        "Payload": {"Title": "test", "Description": "x"}
      }''';

  void _sendActionAndNavigateBack(BuildContext context) {
    TerminalInteractionBloc terminalInteractionBloc =
        BlocProvider.of<TerminalInteractionBloc>(context);
    terminalInteractionBloc.dispatch(ReceiveActionFromTerminalEvent(json));
  }

  void _showModalSheetAddMember(BuildContext context) {
    TerminalInteractionBloc terminalInteractionBloc =
        BlocProvider.of<TerminalInteractionBloc>(context);
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (builder) {
          return Container(
              height: 100,
              child: Column(children: [
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                    "Confirm Action",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      width: 160,
                      child: RaisedButton(
                        elevation: 4,
                        color: Colors.green,
                        child:
                            Text('Yes', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          terminalInteractionBloc
                              .dispatch(ReceiveActionFromTerminalEvent(json));
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      width: 160,
                      child: RaisedButton(
                        elevation: 4,
                        color: Colors.red,
                        child:
                            Text('No', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          terminalInteractionBloc
                              .dispatch(ReceiveActionFromTerminalEvent(json));
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ]));
        });
  }
}
