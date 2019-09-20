import 'dart:convert';
import 'dart:typed_data';

import 'package:bip32/bip32.dart' as bip32;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter/foundation.dart';
import "package:pointycastle/digests/sha256.dart";
import 'package:wetonomy/wallet/network.dart';

class CosmosHDWallet implements HDWallet {
  HDWallet _wallet;
  bip32.BIP32 _bip32;

  @override
  NetworkType network;

  @override
  String seed;

  CosmosHDWallet(
      {@required bip32, @required p2pkh, @required this.network, this.seed})
      : assert(bip32 != null) {
    this._bip32 = bip32;
    this._wallet = HDWallet(
        bip32: bip32, p2pkh: p2pkh, network: this.network, seed: this.seed);
  }

  CosmosHDWallet._(this._bip32, this._wallet)
      : assert(_bip32 != null),
        assert(_wallet != null);

  factory CosmosHDWallet.fromSeed(Uint8List seed) {
    final NetworkType network = cosmos;
    final bip32Wallet = bip32.BIP32.fromSeed(
        seed,
        bip32.NetworkType(
            bip32: bip32.Bip32Type(
                public: network.bip32.public, private: network.bip32.private),
            wif: network.wif));
    final hdWallet = HDWallet.fromSeed(seed, network: network);
    return CosmosHDWallet._(bip32Wallet, hdWallet);
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
    return CosmosHDWallet._(bip32Wallet, hdWallet);
  }

  @override
  String get address => _wallet.address;

  @override
  String get base58 => _wallet.base58;

  @override
  String get base58Priv => _wallet.base58Priv;

  @override
  HDWallet derive(int index) => _wallet.derive(index);

  @override
  HDWallet derivePath(String path) => _wallet.derivePath(path);

  @override
  String get privKey => _wallet.privKey;

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
}
