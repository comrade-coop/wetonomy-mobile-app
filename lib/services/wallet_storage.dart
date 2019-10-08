import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wetonomy/wallet/cosmos_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';

class WalletStorage {
  final FlutterSecureStorage _storage;

  WalletStorage(this._storage) : assert(_storage != null);

  Future<String> storeWallet(Wallet wallet) async {
    String key = wallet.address;
    String json = wallet.toJson();
    await _storage.write(key: wallet.address, value: json);

    return key;
  }

  Future<List<String>> readAllWallets() async {
    Map<String, String> allWallets = await _storage.readAll();
    return allWallets.keys.toList();
  }

  Future<Wallet> readWallet(String key, String password) async {
    String json = await _storage.read(key: key);

    if (json == null || json.isEmpty) {
      throw ArgumentError('Invalid wallet key: ' + key);
    }

    final wallet = CosmosWallet.fromJson(json, password);
    return wallet;
  }
}
