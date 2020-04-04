import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/accent_button.dart';

class AccountCreatedSection extends StatelessWidget {
  final String walletAddress;

  const AccountCreatedSection({Key key, @required this.walletAddress})
      : assert(walletAddress != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildStyledText(Strings.congratulationsMsg, context),
              _buildVerticalSpacing(),
              _buildVerticalSpacing(),
              _buildStyledText(Strings.passwordTips, context),
              _buildVerticalSpacing(),
              _buildStyledText(Strings.cantRecoverMsg, context),
              _buildVerticalSpacing(),
              _buildStyledText(Strings.yourWalletAddressLabel, context),
              _buildAddressCard(walletAddress, context)
            ],
          ),
          AccentButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/terminal'),
            label: Strings.allDoneLabel,
          )
        ],
      ),
    );
  }

  Widget _buildVerticalSpacing() => SizedBox(height: 16);

  Widget _buildStyledText(String text, BuildContext context) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .subhead
            .apply(fontFamily: 'Montserrat'));
  }

  Widget _buildAddressCard(String address, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      margin: EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.black.withAlpha(10),
      ),
      child: Center(
        child: SelectableText(
          address,
          style: Theme.of(context)
              .textTheme
              .body1
              .apply(color: Theme.of(context).accentColor, fontWeightDelta: 2),
        ),
      ),
    );
  }
}
