import 'package:flutter/material.dart';
import 'package:wetonomy/components/password_form_field.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/accent_button.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';

class LoginForm extends StatefulWidget {
  final List<EncryptedWallet> accounts;
  final void Function(EncryptedWallet, String) onSuccessfulValidation;

  const LoginForm(
      {Key key, @required this.accounts, @required this.onSuccessfulValidation})
      : assert(accounts != null),
        assert(onSuccessfulValidation != null),
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  EncryptedWallet _currentAccount;
  List<String> _accountAddresses;
  String _password;

  @override
  void initState() {
    super.initState();

    _accountAddresses = widget.accounts
        .map((EncryptedWallet wallet) => wallet.address)
        .toList();

    // TODO: Implement logging in with most recent account
    _currentAccount = widget.accounts[0];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildAccountSelector(),
          SizedBox(
            height: 16,
          ),
          _buildPasswordField(),
          SizedBox(
            height: 48,
          ),
          _buildSignInBtn()
        ],
      ),
    );
  }

  Widget _buildAccountSelector() {
    return DropdownButton<String>(
      value: _currentAccount?.address,
      isExpanded: true,
      onChanged: (String newAddress) {
        final newAccount = widget.accounts.firstWhere(
            (EncryptedWallet wallet) => wallet.address == newAddress);
        setState(() {
          _currentAccount = newAccount;
        });
      },
      items: _buildAccountItems(),
    );
  }

  Widget _buildPasswordField() {
    return PasswordFormField(
      hintText: Strings.passwordLabel,
      validator: (String value) {
        if (value.isEmpty) {
          return Strings.emptyPasswordError;
        }

        return null;
      },
      onChanged: (String value) => _password = value,
    );
  }

  List<DropdownMenuItem> _buildAccountItems() {
    return _accountAddresses?.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: ConstrainedBox(
          child: Container(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          constraints: BoxConstraints(maxWidth: 250),
        ),
      );
    })?.toList();
  }

  Widget _buildSignInBtn() {
    return AccentButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          widget.onSuccessfulValidation(_currentAccount, _password);
        }
      },
      label: Strings.unlockLabel,
    );
  }
}
