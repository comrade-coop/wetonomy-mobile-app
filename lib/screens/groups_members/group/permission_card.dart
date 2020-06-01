import 'package:flutter/material.dart';
import 'package:wetonomy/screens/groups_members/models/permission.dart';
import '../models/contract_permissions.dart';

class PermissionCard extends StatelessWidget {
  static const cardMargin = EdgeInsets.fromLTRB(25, 20, 25, 10);

  final ContractPermissions contractPermissions;

  const PermissionCard(this.contractPermissions, {Key key}) : super(key: key);

  @override
  Widget build(Object context) {
    var permissions = List<Widget>.generate(
        this.contractPermissions.permissions.length,
        (i) => createTale(context, contractPermissions.permissions[i]));

    return Container(
        margin: cardMargin,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  offset: Offset.fromDirection(2.0),
                  color: Colors.black26)
            ]),
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              child: FractionallySizedBox(
                widthFactor: 1.05,
                // heightFactor: 0.6,
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.0, 6.0),
                            colors: <Color>[
                              Color.fromRGBO(118, 56, 251, 1),
                              Color.fromRGBO(243, 144, 176, 1),
                            ]),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset.fromDirection(2.0),
                              color: Colors.black26)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Contract Name:  ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16.0,
                                )),
                            Text(this.contractPermissions.contractName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: 14.0,
                                )),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Contract Address:   ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16.0,
                                )),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              width: 135,
                              child:
                                  Text(this.contractPermissions.contractAddress,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      )),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            ...permissions
          ],
        ));
  }

  Widget createTale(BuildContext context, Permission perm) {
    return ExpansionTile(
      leading: Icon(
        Icons.code,
        size: 24,
        color: Color.fromRGBO(118, 55, 245, 1),
      ),
      title: Text(perm.permissionsLabel,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(118, 55, 245, 1),
            fontSize: 16.0,
          )),
      children: <Widget>[
        Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            // alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.share,
                  size: 16,
                  color: Theme.of(context).accentColor,
                ),
                Text(
                  "   Shared to",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            )),
        ...generateShareList(context, perm.sharedTo),
        Container(
          padding: EdgeInsets.only(bottom: 10),
          margin: EdgeInsets.symmetric(horizontal: 18),
          // alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.person_add,
                size: 16,
                color: Theme.of(context).accentColor,
              ),
              Text(
                "   Share",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
        )
      ],
      onExpansionChanged: (check) => {},
    );
  }

  List<Widget> generateShareList(BuildContext context, List<String> names) {
    if (names == null) return [];
    return List.generate(
      names.length,
      (index) => ListTile(
        // contentPadding: const EdgeInsets.symmetric(horizontal:50),
        leading: Container(
            margin: const EdgeInsets.only(left: 20),
            child: Icon(
              Icons.person,
              color: Theme.of(context).accentColor,
              size: 22,
            )),
        title: Text(names[index]),
        trailing: Icon(Icons.delete),
        // subtitle:
        //     Text(contracts[index].address, style: TextStyle(fontSize: 10)),
        onTap: () => {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return ActionSelect(contracts[index]);
          // }))
        },
      ),
    );
  }
}
