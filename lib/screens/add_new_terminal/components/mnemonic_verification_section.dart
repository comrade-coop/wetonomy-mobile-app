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
          AccentButton(label: Strings.confirmLabel, onPressed: _verifyMnemonic)
        ],
      ),
    );
  }

  Widget _buildSelectedMnemonicArea() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 200,
          width: double.infinity,
          child: _buildSelectedWords(),
        ),
      ),
    );
  }

  Widget _buildSelectedWords() {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 2,
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
          crossAxisCount: 3,
          childAspectRatio: 2,
          children: _remainingWords
              .map((WordField field) => Center(
                    child: MnemonicWord(
                      word: field.word,
                      onSelected: () {
                        _bloc.dispatch(
                            SelectWordEvent(_remainingWords.indexOf(field)));
                      },
                      selected: field.selected,
                    ),
                  ))
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
}
