import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';

import 'accent_button.dart';

class ViewMnemonicSection extends StatelessWidget {
  final String mnemonic;
  final VoidCallback onNextPressed;

  const ViewMnemonicSection(
      {Key key, @required this.mnemonic, @required this.onNextPressed})
      : assert(mnemonic != null),
        assert(onNextPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildMessagesAndCard(context),
          _buildNextButton(context),
        ],
      ),
    );
  }

  Widget _buildMessagesAndCard(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildPaddedText(Strings.secretPhraseMessage),
        _buildPaddedText(Strings.secretPhraseStorageMessage),
        _buildMnemonicCard(context),
        _buildPaddedText(Strings.secretPhraseWarning),
      ],
    );
  }

  Widget _buildPaddedText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text),
    );
  }

  Widget _buildMnemonicCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Text(
            mnemonic,
            style: Theme.of(context).textTheme.headline,
            textAlign: TextAlign.center,
          )),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return AccentButton(
      onPressed: onNextPressed,
      label: Strings.nextLabel,
    );
  }
}
