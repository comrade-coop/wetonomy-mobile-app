import 'package:flutter/material.dart';
import 'package:wetonomy/screens/groups_members/components/permissions/permission_tile.dart';
import 'package:wetonomy/screens/groups_members/models/contract_permissions.dart';

class PermissionCard extends StatelessWidget {
  static const cardMargin = EdgeInsets.fromLTRB(25, 20, 25, 10);

  final ContractPermissions contractPermissions;

  final String currentDelegateAddress;

  final bool isPersonalPage;

  const PermissionCard(this.contractPermissions, this.currentDelegateAddress,this.isPersonalPage, 
      {Key key})
      : super(key: key);

  @override
  Widget build(Object context) {
    var permissions = List<Widget>.generate(
        this.contractPermissions.permissions.length,
        (i) => PermissionTile(this.contractPermissions.permissions[i],
            this.isPersonalPage, this.currentDelegateAddress));

    return Container(
        margin: PermissionCard.cardMargin,
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
                              Theme.of(context).primaryColor,
                              Theme.of(context).accentColor,
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
}
