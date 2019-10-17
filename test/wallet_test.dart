import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:wetonomy/models/action.dart';
import 'package:wetonomy/services/strongforce_api_client_cosmos.dart';
import 'package:wetonomy/wallet/cosmos_hd_wallet.dart';

import 'wallet_test_data.dart';

void main() {
  test('Test private keys', () {
    final wallet = CosmosHDWallet.fromMnemonic(expectedWallet['mnemonic']);
    expect(wallet.privKeyRaw, expectedWallet['privateKey']);
  });

  test('Test public keys', () {
    final wallet = CosmosHDWallet.fromMnemonic(expectedWallet['mnemonic']);
    expect(wallet.pubKeyRaw, expectedWallet['publicKey']);
  });

  test('Test signing', () {
    final wallet = CosmosHDWallet.fromMnemonic(expectedWallet['mnemonic']);
    final Uint8List signature = wallet.sign('Hello World!');
    expect(signature, expectedWallet['signature']);
  });

  test('Tendermint broadcast', () async {
    var client = StrongForceApiClientCosmos();
    var jsonAction = '{"Targets":["cpdu6PE"],"Type":"CreateAchievement","Payload":{"Describtion":"Achievement: #asd","Recipients":["BB"]}}';
    var action = Action.fromJsonString(jsonAction);
    await client.sendAction(action);
  });

}
