import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:wetonomy/wallet/cosmos_wallet.dart';

import 'wallet_test_data.dart';

void main() {
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
}
