import 'package:flutter/material.dart';
import 'package:wetonomy/screens/groups_members/components/member_select_card.dart';
import 'package:wetonomy/screens/groups_members/models/member.dart';

class AddMember extends StatefulWidget {
  final List<Member> members;

  const AddMember(
    this.members, {
    Key key,
  }) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  List<Member> filteredMembers;
  int activeIndex = -1;

  final userSearchController = TextEditingController();

  @override
  void dispose() {
    userSearchController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    this.filteredMembers = this.widget.members;

    userSearchController.addListener(_userSearch);
  }

  void _userSearch() {
    String input = this.userSearchController.text;
    var members = this
        .widget
        .members
        .where((mem) => mem.name.toLowerCase().contains(input.toLowerCase()));
    this.filteredMembers = members.toList();
    this.setState(() {});
  }

  void setActive(int index) {
    this.setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 470,
        padding: EdgeInsets.fromLTRB(20, 15.0, 20, 0),
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              child: TextField(
                controller: userSearchController,
                decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.clear,
                            color: (this.userSearchController.text.length > 0
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).backgroundColor)),
                        onPressed: () => {
                          this.setState(() {activeIndex = -1;}),
                          userSearchController.clear()
                          })),
              ),
            ),
            if (this.filteredMembers.length > 0)
              Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 385,
                  child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                            color: Colors.white,
                            height: 5,
                          ),
                      itemCount: filteredMembers.length,
                      itemBuilder: (BuildContext ctxt, int ind) {
                        int i = ind % this.filteredMembers.length;

                        return MemberSelectCard(
                          filteredMembers[i],
                          activeIndex == i,
                          setActive,
                          i
                        );
                      }))
            else
              Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child:
                    Text("No matching results", style: TextStyle(fontSize: 18)),
              )
          ],
        ));
  }
}
