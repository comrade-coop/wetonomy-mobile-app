import 'package:flutter/material.dart';
import 'package:myapp/models/contract.dart';
import 'package:myapp/models/contract_action.dart';

class DynamicActionForm extends StatelessWidget {
  final Contract contract;
  final ContractAction action;

  const DynamicActionForm(this.contract, this.action);

  @override
  Widget build(BuildContext context) {
    List<Widget> formItems = [];
    action.parameters.forEach((fieldName, fieldType) => {
          // formItems.add(Container(
          //   margin: const EdgeInsets.symmetric(vertical: 8),
          //   child: Text(fieldName.toUpperCase(), style: TextStyle(fontSize: 16, ),))),
          formItems.add(Container(
            // height: 50,
            margin: const EdgeInsets.only(top: 12),
            child: TextField(
              decoration: InputDecoration(
                  // fillColor: Colors.white,
                  // filled: true,
                  // border: OutlineInputBorder(),
                  labelText: fieldName),
            ),
          ))
        });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Action Form',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              tooltip: 'Search',
              onPressed: null,
            ),
          ],
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ListView(children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Icon(
                  Icons.code,
                  color: Colors.blue,
                ),
                title: Text(
                  action.name,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Text(
                  "${contract.name} Contract: ${contract.address}",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
              ...formItems,
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    color: Colors.blue,
                    child: Text(
                      "Send Action",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  )),
            ]
                )));
  }
}
