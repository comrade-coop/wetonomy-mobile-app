import 'dart:convert';
import 'dart:typed_data';

import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter/foundation.dart';
import "package:pointycastle/digests/sha256.dart";
import 'package:wetonomy/wallet/network.dart';

const String _derivationPath = 'm/44\'/118\'/0\'/0/0';
const List<int> _aminoPublicKeyPrefix = [235, 90, 233, 135, 33];

class CosmosHDWallet implements HDWallet {
  final HDWallet _wallet;
  final bip32.BIP32 _bip32;

  @override
  NetworkType network;

  @override
  String seed;

  CosmosHDWallet._(this._bip32, this._wallet)
      : assert(_bip32 != null),
        assert(_wallet != null) {
    network = _wallet.network;
    seed = _wallet.seed;
  }

  factory CosmosHDWallet.fromMnemonic(String mnemonic) {
    return CosmosHDWallet.fromSeed(bip39.mnemonicToSeed(mnemonic));
  }

  factory CosmosHDWallet.fromSeed(Uint8List seed) {
    final NetworkType network = cosmos;
    final bip32Wallet = bip32.BIP32.fromSeed(
        seed,
        bip32.NetworkType(
            bip32: bip32.Bip32Type(
                public: network.bip32.public, private: network.bip32.private),
            wif: network.wif));
    final hdWallet = HDWallet.fromSeed(seed, network: network);
    final cosmosWallet = CosmosHDWallet._(bip32Wallet, hdWallet);

    return cosmosWallet.derivePath(_derivationPath);
  }

  factory CosmosHDWallet.fromBase58(String xpub) {
    final NetworkType network = cosmos;
    final bip32Wallet = bip32.BIP32.fromBase58(
        xpub,
        bip32.NetworkType(
            bip32: bip32.Bip32Type(
                public: network.bip32.public, private: network.bip32.private),
            wif: network.wif));
    final hdWallet = HDWallet.fromBase58(xpub, network: network);
    final cosmosWallet = CosmosHDWallet._(bip32Wallet, hdWallet);

    return cosmosWallet.derivePath(_derivationPath);
  }

  @override
  String get address => _wallet.address;

  @override
  String get base58 => _wallet.base58;

  @override
  String get base58Priv => _wallet.base58Priv;

  @override
  HDWallet derive(int index) {
    final bip32 = _bip32.derive(index);
    final wallet = _wallet.derive(index);
    return CosmosHDWallet._(bip32, wallet);
  }

  @override
  HDWallet derivePath(String path) {
    final bip32 = _bip32.derivePath(path);
    final wallet = _wallet.derivePath(path);
    return CosmosHDWallet._(bip32, wallet);
  }

  @override
  String get privKey => _wallet.privKey;

  // TODO: Convert pubKey to use Cosmos encoding
  @override
  String get pubKey => _wallet.pubKey;

  @override
  Uint8List sign(String message) {
    Uint8List messageHash = SHA256Digest().process(utf8.encode(message));
    return _bip32.sign(messageHash);
  }

  @override
  bool verify({@required String message, @required Uint8List signature}) {
    Uint8List messageHash = SHA256Digest().process(utf8.encode(message));
    return _bip32.verify(messageHash, signature);
  }

  @override
  String get wif => _wallet.wif;

  Uint8List get privKeyRaw => _bip32.privateKey;

  // Dirty fix in order to make the public key compatible with cosmos' amino encoded public keys
  Uint8List get pubKeyRaw =>
      Uint8List.fromList(_aminoPublicKeyPrefix + _bip32?.publicKey);
  
  Uint8List get pubKeyWithoutAmino => Uint8List.fromList(_bip32?.publicKey);
}
