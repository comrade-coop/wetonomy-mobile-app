import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wetonomy/models/wallet/encrypted_wallet_file.dart';
import 'package:wetonomy/wallet/cosmos_encrypted_wallet.dart';
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

  Future<List<String>> readAllWallets() async {
    Map<String, String> allWallets = await _storage.readAll();
    return allWallets.keys.toList();
  }

  Future<EncryptedWallet> readWallet(String key, String password) async {
    String json = await _storage.read(key: key);

    if (json == null || json.isEmpty) {
      throw ArgumentError('Invalid wallet key: ' + key);
    }

    final Map<String, dynamic> jsonMap = jsonDecode(json);
    final encrypted = EncryptedWalletFile.fromJson(jsonMap);
    return CosmosEncryptedWallet.fromEncryptedWalletFile(encrypted);
  }
}
