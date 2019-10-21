import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/bloc/mnemonic_verification/word_field.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/accent_button.dart';
import 'package:wetonomy/screens/create_account/components/memonic_word.dart';

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
  MnemonicVerificationBloc _bloc;
  List<WordField> _selectedWords = [];
  List<WordField> _remainingWords = [];

  static const int _crossAxisWordCount = 3;
  static const double _wordAspectRatio = 2;

  @override
  void initState() {
    super.initState();
    _bloc = MnemonicVerificationBloc(widget.mnemonic.split(' '));

    _bloc.state.listen((MnemonicVerificationState state) {
      setState(() {
        _selectedWords = state.selectedWords;
        _remainingWords = state.remainingWords;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: <Widget>[
          Text(Strings.confirmMnemonicMsg),
          _buildSelectedMnemonicArea(),
          _buildMnemonicPieces(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AccentButton(
                  label: Strings.confirmLabel, onPressed: _verifyMnemonic),
              _buildDebugSkipBtn()
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSelectedMnemonicArea() {
    return Expanded(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: _buildSelectedWords(),
        ),
      ),
    );
  }

  Widget _buildSelectedWords() {
    return GridView.count(
      crossAxisCount: _crossAxisWordCount,
      childAspectRatio: _wordAspectRatio,
      children: _selectedWords.map((WordField field) {
        return Center(
          child: MnemonicWord(
            word: field.word,
            onSelected: () {
              _bloc.dispatch(UnSelectWordEvent(_selectedWords.indexOf(field)));
            },
            selected: field.selected,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMnemonicPieces() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: GridView.count(
          crossAxisCount: _crossAxisWordCount,
          childAspectRatio: _wordAspectRatio,
          children: _remainingWords
              .map((WordField field) => _buildMnemonicWord(field))
              .toList(),
        ),
      ),
    );
  }

  void _verifyMnemonic() {
    if (_bloc.currentState.isValidSequence) {
      widget.onSuccessfulVerification();
    } else {
      final snackBar = SnackBar(content: Text(Strings.wrongMnemonicMsg));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  Widget _buildDebugSkipBtn() {
    if (!kDebugMode) {
      return SizedBox.shrink();
    }

    return FlatButton(
        child: Text(
          Strings.skipLabelDebug,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        onPressed: widget.onSuccessfulVerification);
  }

  Widget _buildMnemonicWord(WordField field) {
    return Center(
      child: MnemonicWord(
        word: field.word,
        onSelected: () {
          _bloc.dispatch(SelectWordEvent(_remainingWords.indexOf(field)));
        },
        selected: field.selected,
      ),
    );
  }
}
