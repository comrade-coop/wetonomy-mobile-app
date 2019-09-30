import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/welcome/components/accent_text_button.dart';
import 'package:wetonomy/screens/welcome/sections/welcome_section_scaffold.dart';

class ViewSecretPhraseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WelcomeSectionScaffold(
      title: Strings.secretPhraseLabel,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(Strings.secretPhraseMessage),
                    SizedBox(
                      height: 8,
                    ),
                    Text(Strings.secretPhraseStorageMessage),
                    SizedBox(
                      height: 8,
                    ),
                    _buildMnemonicCard(context),
                    SizedBox(
                      height: 8,
                    ),
                    Text(Strings.secretPhraseWarning),
                  ],
                ),
              ),
              AccentTextButton(
                onPressed: () {},
                label: Strings.nextLabel,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMnemonicCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24),
          child: Text(
            'witch collapse practice feed shame open despair creek road again ice least',
            style: Theme.of(context).textTheme.headline,
            textAlign: TextAlign.center,
          )),
    );
  }
}
