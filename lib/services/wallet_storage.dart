import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wetonomy/models/wallet/encrypted_wallet_file.dart';
import 'package:wetonomy/wallet/scrypt_encrypted_wallet.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';

class WalletStorage {
  final FlutterSecureStorage _storage;

  WalletStorage(this._storage) : assert(_storage != null);

  Future<String> storeWallet(EncryptedWallet wallet) async {
    String key = wallet.address;

    final Map<String, dynamic> encrypted =
        wallet.toEncryptedWalletFile().toJson();
    await _storage.write(key: wallet.address, value: jsonEncode(encrypted));

    return key;
  }

  Future<List<EncryptedWallet>> readAllWallets() async {
    Map<String, String> walletEntries = await _storage.readAll();

    final List<EncryptedWallet> encrypted = walletEntries != null
        ? walletEntries.values
            .map((String json) => _toEncryptedWallet(json))
            .toList()
        : [];
    return encrypted;
  }

  Future<EncryptedWallet> readWallet(String key) async {
    String json = await _storage.read(key: key);

    if (json == null) {
      throw ArgumentError('Invalid wallet key: ' + key);
    }

    return _toEncryptedWallet(json);
  }

  EncryptedWallet _toEncryptedWallet(String json) {
    final Map<String, dynamic> jsonWallet = jsonDecode(json);
    final file = EncryptedWalletFile.fromJson(jsonWallet);
    return ScryptEncryptedWallet.fromEncryptedWalletFile(file);
  }
}
