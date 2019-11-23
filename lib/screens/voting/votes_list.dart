import 'package:flutter/material.dart';

class Vote {
  final String user;
  final String vote;
  Vote(this.user, this.vote);
}

class VotesList extends StatefulWidget {
  // VotesList({Key key}) : super(key: key);

  @override
  _VotesListState createState() => _VotesListState();
}

class _VotesListState extends State<VotesList> {
  List<String> filters = [];
  Map<String, IconData> icons = {};
  Map<String, Color> colors = {"yes": Colors.green, "no": Colors.red};

  Color activeColor = Colors.grey.shade300;

  final int filtersCount;

  _VotesListState({this.filtersCount = 2}) {
    if (filtersCount == 2) icons = {"yes": Icons.check, "no": Icons.close};
  }

  void _handleTap(String newFilter) {
    if (filters.contains(newFilter)) {
      filters.remove(newFilter);
      activeColor = Colors.grey.shade300;
    } else {
      if (filtersCount == filters.length + 1) filters = [];
      filters.add(newFilter);
      activeColor = colors[newFilter];
    }

    setState(() {});
  }

  Widget build(BuildContext context) {
    List<Vote> entries = [
      Vote("Ioan Stoianov", "yes"),
      Vote("Petar Ivanov", "no"),
      Vote("Ioan Stoianov", "yes"),
      Vote("Ioan Stoianov", "yes"),
      Vote("Petar Ivanov", "no"),
      Vote("Petar Ivanov", "no"),
      Vote("Ioan Stoianov", "yes"),
      Vote("Ioan Stoianov", "yes"),
      Vote("Petar Ivanov", "no"),
      Vote("Petar Ivanov", "no"),
      Vote("Petar Ivanov", "no"),
    ];

    List<Vote> filteredEntries = [];
    if (filters.isNotEmpty)
      filteredEntries =
          entries.where((item) => filters.contains(item.vote)).toList();
    else
      filteredEntries = entries;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          // title: Text('Vote №1', style: TextStyle(color: Colors.black),),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              tooltip: 'Search',
              onPressed: null,
            ),
          ],
        ),
        body: Column(children: <Widget>[
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Filters",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                Container(
                    width: 80,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _generateFilterButtons()))
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 2.0, color: activeColor))),
              child: ListView.separated(
                itemCount: filteredEntries.length,
                itemBuilder: (BuildContext context, int index) {
                  String vote = filteredEntries[index].vote;
                  return ListTile(
                    leading: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                          color:
                              icons[vote] != null ? Colors.white : colors[vote],
                          borderRadius: BorderRadius.circular(30)),
                      child: icons[vote] != null
                          ? Icon(
                              icons[vote],
                              color: colors[vote],
                            )
                          : Container(),
                    ),
                    title: Text(filteredEntries[index].user,
                        style: TextStyle(fontWeight: FontWeight.w400)),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                padding: const EdgeInsets.all(0),
              ),
            ),
          )
        ]));
  }

  List<Widget> _generateFilterButtons() {
    List<String> options = ["yes", "no"];

    return options
        .map((option) => Container(
              width: (filters.contains(option)) ? 28 : 24,
              height: (filters.contains(option)) ? 28 : 24,
              decoration: BoxDecoration(
                  color: colors[option],
                  borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                iconSize: 18,
                padding: const EdgeInsets.all(0),
                color: Colors.white,
                icon: icons[option] != null ? Icon(icons[option]) : Container(),
                tooltip: 'Voted with $option',
                onPressed: () => _handleTap(option),
              ),
            ))
        .toList();
  }
}
