import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:wetonomy/wallet/cosmos_wallet.dart';

import 'wallet_test_data.dart';

void main() {
  test('Test private keys', () {
    final wallet =
        CosmosWallet.fromMnemonic(expectedWallet['mnemonic'], Uint8List(0));
    expect(wallet.privateKey, expectedWallet['privateKey']);
  });

  test('Test public keys', () {
    final wallet =
        CosmosWallet.fromMnemonic(expectedWallet['mnemonic'], Uint8List(0));
    expect(wallet.publicKey, expectedWallet['publicKey']);
  });

  test('Test signing', () {
    final wallet =
        CosmosWallet.fromMnemonic(expectedWallet['mnemonic'], Uint8List(0));
    final Uint8List signature = wallet.sign('Hello World!');
    expect(signature, expectedWallet['signature']);
  });

  test('Test fromBase58', () {
    final wallet =
        CosmosWallet.fromMnemonic(expectedWallet['mnemonic'], Uint8List(0));
  });
}
