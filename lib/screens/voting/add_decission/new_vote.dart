import 'package:flutter/material.dart';
import '../models/contract.dart';
import '../dummy_data.dart';
import 'action_select.dart';

class NewVote extends StatelessWidget {

  Widget build(BuildContext context) {
    List<String> contractsTypes = dummyContractsTypes;
    Map<String, List<Contract>> contractsByTypes = dummyContractsByTypes;
    
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'New Vote',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              tooltip: 'Search',
              onPressed: ()=>{
                Navigator.of(context).popUntil((route) => route.isFirst)
              },
            ),
          ],
        ),
        body: Container(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey.shade300,
              thickness: 1,
              height: 1,
            ),
            itemCount: contractsTypes.length,
            itemBuilder: (context, index) => ExpansionTile(
                leading: Icon(
                  Icons.fiber_manual_record,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(contractsTypes[index],
                    style: TextStyle(fontWeight: FontWeight.w400)),
                initiallyExpanded: false,
                children: _generateContractList(
                    context, contractsByTypes[contractsTypes[index]])),
          ),
        ));
  }

  List<Widget> _generateContractList(
      BuildContext context, List<Contract> contracts) {
    if (contracts == null) return [];
    return List.generate(
      contracts.length,
      (index) => ListTile(
        // contentPadding: const EdgeInsets.symmetric(horizontal:50),
        leading: Container(
            margin: const EdgeInsets.only(left: 20),
            child: Icon(
              Icons.hdr_strong,
              color: Theme.of(context).accentColor,
              size: 22,
            )),
        title: Text(contracts[index].name),
        subtitle:
            Text(contracts[index].address, style: TextStyle(fontSize: 10)),
        onTap: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ActionSelect(contracts[index]);
          }))
        },
      ),
    );
  }
}
