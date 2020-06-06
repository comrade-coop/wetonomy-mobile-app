import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_state.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_bloc.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_state.dart';
import 'package:wetonomy/screens/shared/sliver_appbar_delegate.dart';
import 'package:wetonomy/screens/shared/terminal_interaction.dart';
import 'package:wetonomy/screens/shared/wetonomy_app_bar.dart';
import 'package:wetonomy/screens/shared/wetonomy_icon_button.dart';
import 'package:wetonomy/screens/terminal/components/terminal_drawer_container.dart';

import './add_decission/new_vote.dart';
import './dummy_data.dart';
import './vote_box.dart';
import 'detailed_vote_box.dart';

//Highly possible to extract parent class for native terminals in the future
//leaving it for now because of no use case yet

class VotingTerminal extends StatefulWidget{
  @override
  _VotingTerminalState createState() => _VotingTerminalState();
}

class _VotingTerminalState extends State<VotingTerminal> with TerminalInteraction {

  TerminalInteractionBloc _terminalInteractionBloc;
  StreamSubscription<TerminalInteractionState>
      _terminalInteractionBlocSubscription;

  @override
  void initState() {
    super.initState();

    _terminalInteractionBloc =
        BlocProvider.of<TerminalInteractionBloc>(context);

    _terminalInteractionBlocSubscription =
        _terminalInteractionBloc.state.listen(_handleTerminalStateChange);
  }

  @override
  void dispose() {
    _terminalInteractionBlocSubscription?.cancel();
    super.dispose();
  }

  void _handleTerminalStateChange(TerminalInteractionState state) {
    if (state is ReceiveActionFromTerminalState) {
      showSnackBar("Sending Action", snackBarColor);
    }
    // else if (state is ...) {}
  }

  @override
  Widget build(BuildContext context) {
    super.snackBarColor = Theme.of(context).primaryColor;


    final accountsBlock = BlocProvider.of<AccountsBloc>(context);
    final AccountsState state = accountsBlock.currentState;
    String currentUserAddress;
    if (state is LoggedInState) {
      currentUserAddress = state.wallet.address;
    }
    // print(currentUserAddress);

    var decisions = dummyDecisions;
    var decisionsList = List.generate(
        decisions.length,
        (index) => GestureDetector(
              child: Hero(
                  transitionOnUserGestures: true,
                  tag: 'imageHero_$index',
                  child: VoteBoxWrapper(decisions[index])),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailScreen(
                      index, decisions[index], currentUserAddress);
                }));
              },
            ));

    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 236, 236, 1),
      key: super.scaffoldKey,
      drawer: TerminalDrawerContainer(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                    minHeight: 100.0,
                    maxHeight: 250.0,
                    child: LayoutBuilder(
                      builder: (context, BoxConstraints constraints) {
                        double persentage = (constraints.maxHeight - 100) / 150;
                        double size = 40 + 90 * persentage;
                        double width = MediaQuery.of(context).size.width;

                        double rightMargin =
                            42 + (width / 2 - 105) * persentage;
                        double topMargin = 33 + persentage * 70;

                        return Container(
                            decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment(0.0, 3.0),
                                    colors: <Color>[
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).accentColor,
                                    ]),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.elliptical(
                                            200, 20 + 30 * persentage))),
                                shadows: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset.fromDirection(2.0),
                                      color: Colors.black54)
                                ]),
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: WetonomyAppBar(
                                    "",
                                    currentUser,
                                    leading: WetonomyIconButton(IconButton(
                                      icon: Icon(
                                        Icons.menu,
                                        color: Colors.black54,
                                      ),
                                      onPressed: () =>
                                          Scaffold.of(context).openDrawer(),
                                    )),
                                  ),
                                ),
                                Positioned(
                                  right: width / 2 - 55 * persentage,
                                  top: 43,
                                  child: Container(
                                      width: 110,
                                      child: Center(
                                        child: Text(
                                          "Decisions",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              shadows: [
                                                Shadow(
                                                    blurRadius: 3.5,
                                                    color: Colors.white)
                                              ]),
                                        ),
                                      )),
                                ),
                                Positioned(
                                    top: 25,
                                    right: 66,
                                    child: Opacity(
                                      opacity: (constraints.maxHeight > 150
                                          ? 0
                                          : 1 - persentage),
                                      child: WetonomyIconButton(
                                        IconButton(
                                            icon: Icon(
                                              Icons.search,
                                              color: Colors.black54,
                                            ),
                                            onPressed: () => {}
                                            // this.switchView(true),
                                            ),
                                      ),
                                    )),
                                Positioned(
                                    top: topMargin,
                                    right: rightMargin,
                                    child: Container(
                                        width: size * 1,
                                        height: size,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              33 * persentage),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 3.0,
                                            )
                                          ],
                                        ),
                                        child: IconButton(
                                            icon: Opacity(
                                              opacity: 0.55,
                                              child: Image.asset(
                                                'assets/images/clipart1140799.png',
                                                width: 70,
                                              ),
                                            ),
                                            onPressed: () => {}))),
                              ],
                            ));
                      },
                    ))),
          ];
        },
        body: ListView(
          children: <Widget>[
            ...decisionsList,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', 
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return NewVote();
          }));
        },
      ),
    );
  }

  
}
