import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/bloc.dart';

class ShowModal {
  final String json = '''{
        "Targets": ["0x00000000000000000000"],
        "Type": "CreateAchievement",
        "Payload": {"Title": "test", "Description": "x"}
      }''';

  void showModalSheetConfirmation(BuildContext context) {
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
                          BlocProvider.of<TerminalInteractionBloc>(context)
                              .add(ReceiveActionFromTerminalEvent(json));
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
                          BlocProvider.of<TerminalInteractionBloc>(context)
                              .add(ReceiveActionFromTerminalEvent(json));
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
