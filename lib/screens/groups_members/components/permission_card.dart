import 'package:flutter/material.dart';
import 'package:wetonomy/screens/groups_members/components/add_member.dart';
import 'package:wetonomy/screens/groups_members/components/shared_permission.dart';
import 'package:wetonomy/screens/groups_members/dummy_data.dart';
import 'package:wetonomy/screens/groups_members/models/permission.dart';
import '../models/contract_permissions.dart';

class PermissionCard extends StatefulWidget {
  static const cardMargin = EdgeInsets.fromLTRB(25, 20, 25, 10);

  final ContractPermissions contractPermissions;

  final String currentDelegateAddress;


  const PermissionCard(this.contractPermissions, this.currentDelegateAddress,
      {Key key})
      : super(key: key);

  @override
  _PermissionCardState createState() => _PermissionCardState();
}

class _PermissionCardState extends State<PermissionCard> {
  int activeIndex = -1;

  void setActive(int index) {
    this.setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(Object context) {
    var permissions = List<Widget>.generate(
        this.widget.contractPermissions.permissions.length,
        (i) => createTale(context, widget.contractPermissions.permissions[i]));

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
                            Text(this.widget.contractPermissions.contractName,
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
                                  Text(this.widget.contractPermissions.contractAddress,
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
    Widget _subtitle = Text("");

    if (perm.ownerAddress != widget.currentDelegateAddress) {
      // TODO create dynamic Name fetch
      String name =
          members.firstWhere((mem) => mem.address == perm.ownerAddress).name;
      _subtitle = Text(
        "Shared from $name",
        style: TextStyle(fontSize: 10),
      );
    }

    Widget _leading = Icon(
      Icons.code,
      size: 24,
      color: Color.fromRGBO(118, 55, 245, 1),
    );
    Widget _title = Text(perm.permissionsLabel,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(118, 55, 245, 1),
          fontSize: 16.0,
        ));
    if (perm.ownerAddress == widget.currentDelegateAddress && perm.sharedTo.length > 0) {
      return ExpansionTile(
        leading: _leading,
        title: _title,
        subtitle: _subtitle,
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
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    "   Shared to",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              )),
          ...generateShareList(context, perm.sharedTo),
          FlatButton(
            onPressed: ()=>this.showModalSheetSharePermission(context),
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.symmetric(horizontal: 18),
              // alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.person_add,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    "   Share",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
        onExpansionChanged: (check) => {
          this.setActive(-1)
        },
      );
    } else {
      return ListTile(leading: _leading, title: _title, subtitle: _subtitle);
    }
  }

  List<Widget> generateShareList(BuildContext context, List<String> names) {
    if (names == null) return [];
    return List.generate(
      names.length,
      (index) => SharedPermission(names[index],setActive, activeIndex == index ,index)
    );
  }

  void showModalSheetSharePermission(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (builder) {
          return AddMember([currentUserMetaData]);
        });
  }
}
