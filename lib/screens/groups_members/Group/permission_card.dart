import 'package:flutter/material.dart';
import 'package:members/models/contract_permission.dart';

class PermissionCard extends StatelessWidget {
  static const cardMargin = EdgeInsets.fromLTRB(25, 20, 25, 10);

  final ContractPermissions contractPermissions;

  const PermissionCard(this.contractPermissions, {Key key}) : super(key: key);

  @override
  Widget build(Object context) {
    var permissions = List<ListTile>.generate(
      this.contractPermissions.permissions.length,
      (i) => ListTile(
        leading: Icon(
          Icons.code,
          size: 24,
          color: Color.fromRGBO(118, 55, 245, 1),
        ),
        title: Text(contractPermissions.permissions[i],
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(118, 55, 245, 1),
              fontSize: 16.0,
            )),
        trailing: Icon(Icons.more_vert),
      ),
    );

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
                              child: Text(
                                  this.contractPermissions.contractAddress,
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
