import 'package:flutter/material.dart';
import 'package:wetonomy/components/password_form_field.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/create_account/components/accent_button.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';

class LoginForm extends StatefulWidget {
  final List<EncryptedWallet> accounts;
  final void Function(EncryptedWallet, String) onSuccessfulValidation;
  final bool validatingPassword;
  final bool wrongPassword;

  const LoginForm(
      {Key key,
      @required this.accounts,
      @required this.onSuccessfulValidation,
      this.validatingPassword = false,
      this.wrongPassword = false})
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

  bool _shouldShowEmptyPassword = false;
  bool _shouldShowWrongPassword = false;

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).primaryColorDark.withAlpha(70),
              blurRadius: 20,
              offset: Offset(0, 8))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Strings.loginLabel,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 16,
          ),
          _buildForm()
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildAccountSelector(),
          SizedBox(
            height: 24,
          ),
          _buildPasswordField(),
          SizedBox(
            height: 48,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            _buildProgressBar(),
            SizedBox(
              width: 16,
            ),
            _buildSignInBtn()
          ])
        ],
      ),
    );
  }

  Widget _buildAccountSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Account'),
        DropdownButton<String>(
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
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return PasswordFormField(
      labelText: Strings.passwordLabel,
      autoValidate: true,
      validator: (String value) {
        if (value.isEmpty && _shouldShowEmptyPassword) {
          return Strings.emptyPasswordError;
        }

        if (value.isNotEmpty && !_shouldShowEmptyPassword) {
          _shouldShowEmptyPassword = true;
          return null;
        }

        if (widget.wrongPassword && _shouldShowWrongPassword) {
          _shouldShowWrongPassword = false;
          return Strings.wrongPasswordError;
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
          setState(() {
            _shouldShowWrongPassword = true;
          });
          widget.onSuccessfulValidation(_currentAccount, _password);
        }
      },
      label: Strings.unlockLabel,
    );
  }

  Widget _buildProgressBar() {
    if (widget.validatingPassword) {
      return SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ));
    }
    return SizedBox.shrink();
  }
}
