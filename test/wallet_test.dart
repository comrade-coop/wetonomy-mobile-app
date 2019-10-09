import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:wetonomy/wallet/cosmos_wallet.dart';

import 'wallet_test_data.dart';

void main() {
  group('Wallet', () {
    test('Creates correct private key', () {
      final wallet =
          CosmosWallet.fromMnemonic(expectedWallet['mnemonic'], Uint8List(0));
      expect(wallet.privateKey, expectedWallet['privateKey']);
    });

    test('Creates correct public key', () {
      final wallet =
          CosmosWallet.fromMnemonic(expectedWallet['mnemonic'], Uint8List(0));
      expect(wallet.publicKey, expectedWallet['publicKey']);
    });

    test('Signes messages correctly', () {
      final wallet =
          CosmosWallet.fromMnemonic(expectedWallet['mnemonic'], Uint8List(0));
      final Uint8List signature = wallet.sign('Hello World!');
      expect(signature, expectedWallet['signature']);
    });

    test('Creates a wallet from base58 correctly', () {
      final wallet =
          CosmosWallet.fromMnemonic(expectedWallet['mnemonic'], Uint8List(0));
      final Uint8List iv = wallet.iv;

      String base58 = wallet.toBase58();
      final base58Wallet = CosmosWallet.fromBase58(base58, Uint8List(0), iv);

      expect(base58Wallet.privateKey, wallet.privateKey);
    });

    test('fromJson works correctly', () {
      final String password = 'testpass';
      final wallet = CosmosWallet.fromMnemonic(expectedWallet['mnemonic'],
          Uint8List.fromList(utf8.encode(password)));
      String walletJson = wallet.toJson();

      final decodedWallet = CosmosWallet.fromJson(walletJson, password);

      expect(decodedWallet.privateKey, wallet.privateKey);
    });

    test('fromJson throws when invalid password is used', () {
      final String password = 'testpass';
      final wallet = CosmosWallet.fromMnemonic(expectedWallet['mnemonic'],
          Uint8List.fromList(utf8.encode(password)));
      String walletJson = wallet.toJson();

      expect(() => CosmosWallet.fromJson(walletJson, 'wrongpass'),
          throwsArgumentError);
    });

    test('fromJson throws when invalid json is sent', () {
      final String json = 'Invalid json';
      expect(() => CosmosWallet.fromJson(json, ''), throwsFormatException);
    });

    test('fromJson throws when invalid wallet json is parsed', () {
      final wallet =
          CosmosWallet.fromMnemonic(expectedWallet['mnemonic'], Uint8List(0));
      final Map<String, dynamic> walletJson = json.decode(wallet.toJson());

      print(json.encode(walletJson));

      final emptyJson = '{}';
      expect(() => CosmosWallet.fromJson(emptyJson, ''), throwsArgumentError);

      final dynamic kdf = walletJson['crypto'].remove('kdf');
      expect(() => CosmosWallet.fromJson(json.encode(walletJson), ''),
          throwsArgumentError);
      walletJson['crypto']['kdf'] = kdf;

      walletJson['crypto'].remove('mac');
      expect(() => CosmosWallet.fromJson(json.encode(walletJson), ''),
          throwsArgumentError);
    });
  });
}
