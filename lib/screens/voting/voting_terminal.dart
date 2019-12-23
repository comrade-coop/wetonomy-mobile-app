import 'dart:async';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_state.dart';

import 'package:flutter/material.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_bloc.dart';
import 'package:wetonomy/models/terminal_data.dart';
import 'package:wetonomy/screens/terminal/components/terminal_app_bar.dart';
import 'package:wetonomy/screens/terminal/components/terminal_drawer_container.dart';

import './add_decission/new_vote.dart';
import './dummy_data.dart';
import './vote_box.dart';

import 'detailed_vote_box.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_state.dart';

//Highly possible to extract parent class for native terminals in the future
//leaving it for now because of no use case yet

class VotingTerminal extends StatefulWidget {
  @override
  _VotingTerminalState createState() => _VotingTerminalState();
}

class _VotingTerminalState extends State<VotingTerminal> {
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
      _showSnackBar("Sending Action");
    }
    // else if (state is ...) {}
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                  return DetailScreen(index, decisions[index],
                      currentUserAddress);
                }));
              },
            ));

    return Scaffold(
      key: scaffoldKey,
      drawer: TerminalDrawerContainer(),
      appBar: buildTerminalAppBar(
        terminal: TerminalData("voting", "Decisions", nativeTerminal: true),
      ),
      body: ListView(
        children: <Widget>[
          ...decisionsList,
          Container(
            padding: const EdgeInsets.only(bottom: 20),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return NewVote();
          }));
        },
      ),
    );
  }

  void _showSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: Color.fromARGB(255, 131, 111, 254),
        content: new Text(message)));
  }
}
