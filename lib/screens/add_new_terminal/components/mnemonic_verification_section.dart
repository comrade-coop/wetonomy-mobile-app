import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/accent_button.dart';

class MnemonicVerificationSection extends StatefulWidget {
  final String mnemonic;
  final VoidCallback onSuccessfulVerification;

  const MnemonicVerificationSection(
      {Key key,
      @required this.mnemonic,
      @required this.onSuccessfulVerification})
      : assert(mnemonic != null),
        assert(onSuccessfulVerification != null),
        super(key: key);

  @override
  _MnemonicVerificationSectionState createState() =>
      _MnemonicVerificationSectionState();
}

class _MnemonicVerificationSectionState
    extends State<MnemonicVerificationSection> {
  List<String> _mnemonicList;
  List<String> _mnemonicShuffled;

  @override
  void initState() {
    super.initState();

    _mnemonicList = widget.mnemonic.split(' ');
    _mnemonicShuffled = []..addAll(_mnemonicList);
    _mnemonicShuffled.shuffle(Random());

    print(_mnemonicList);
    print(_mnemonicShuffled);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: <Widget>[
          _buildMessage(),
          _buildMnemonicDraggableArea(),
          _buildMnemonicPieces(),
          AccentButton(label: Strings.confirmLabel, onPressed: _verifyMnemonic)
        ],
      ),
    );
  }

  Widget _buildMnemonicDraggableArea() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 120,
        width: double.infinity,
      ),
    );
  }

  Widget _buildMnemonicPieces() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 3,
          childAspectRatio: 2,
          // Generate 100 widgets that display their index in the List.
          children: _mnemonicShuffled.map((String word) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: Text(
                    word,
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _verifyMnemonic() {
    widget.onSuccessfulVerification();
  }

  Widget _buildMessage() {
    return Text(Strings.confirmMnemonicMessage);
  }
}
