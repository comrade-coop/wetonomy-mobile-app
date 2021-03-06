import 'package:flutter/material.dart';
import 'package:wetonomy/components/waves_background_container.dart';
import 'package:wetonomy/screens/login/login_section.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';

class LoginScreen extends StatelessWidget {
  final List<EncryptedWallet> accounts;

  const LoginScreen({Key key, this.accounts})
      : assert(accounts != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return WavesBackgroundContainer(
      waveHeightPercentage: 0.6,
      child: Material(
          color: Colors.transparent,
          child: Container(
              padding: EdgeInsets.all(32),
              child: SafeArea(
                child: LoginSection(
                  accounts: accounts,
                ),
              ))),
    );
  }
}
