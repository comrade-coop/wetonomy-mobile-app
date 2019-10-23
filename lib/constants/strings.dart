class Strings {
  Strings._();

  static const String appName = 'Wetonomy';
  static const String welcomeMsg =
      'Work with each other,\n not for one another';
  static const String createAccountLabel = 'Create new Account';
  static const String importAccountLabel = 'Import from Seed Phrase';

  static const String createPasswordLabel = 'Create a Password';
  static const String passwordLabel = 'Password';
  static const String confirmPasswordLabel = 'Confirm Password';
  static const String secretPhraseLabel = 'Secret Backup Phrase';
  static const String nextLabel = 'Next';
  static const String allDoneLabel = 'All Done';
  static const String secretPhraseMsg =
      'Your secret backup phrase makes it easy to back up and restore your account.';
  static const String secretPhraseStorageMsg =
      'Store it in a Password Manager or write it down on a piece of paper and keep it in a safe place.';
  static const String secretPhraseWarning =
      'WARNING: Never disclose your backup phrase. Anyone with this phrase can access your account.';
  static const String congratulationsLabel = 'Congratulations';
  static const String congratulationsMsg =
      'You passed the test - keep your secret phrase safe, its your responsibility!';
  static const String passwordTips = '''
Tips on storing it safely: 

• Save a backup in multiple places.
• Never share the phrase with anyone.
• Be careful of malicious apps! Wetonomy will never spontaneously ask for your seed phrase. 
  ''';
  static const String cantRecoverMsg =
      '* Wetonomy cannot recover your seed phrase.';
  static const String confirmMnemonic = 'Confirm Secret Phrase';

  static const String passwordsMatchError = 'Passwords don\'t match';
  static String emptyPasswordError = 'Password can not be empty';
  static const String creatingMnemonicLabel = 'Creating Mnemonic…';
  static const String savingAccountLabel = 'Saving Account…';
  static const String confirmLabel = 'Confirm';

  static const String confirmMnemonicMsg =
      'Please rebuild the mnemonic sequence in order to make sure you\'ve remembered it.';

  static const String wrongMnemonicMsg =
      'Wrong mnemonic! Make sure you\'ve written it down correctly.';

  static String minCharsPassword(int minChars) =>
      'Minimum $minChars characters';
  static const String skipLabelDebug = 'Skip (Debug only)';

  static const String yourWalletAddressLabel = 'Your wallet address is:';
  static const String loadingAccountsLabel = 'Loading Accounts…';
}
