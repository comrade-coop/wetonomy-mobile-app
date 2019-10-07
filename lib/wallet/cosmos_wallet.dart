import 'dart:convert';
import 'dart:typed_data';

import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import "package:pointycastle/digests/sha256.dart";
import 'package:wetonomy/wallet/network.dart';
import 'package:wetonomy/wallet/wallet.dart' as wetonomy;

class CosmosWallet implements wetonomy.Wallet {
  static final String _derivationPath = 'm/44\'/118\'/0\'/0/0';
  static final List<int> _aminoPublicKeyPrefix = [235, 90, 233, 135, 33];

  final HDWallet _wallet;
  final bip32.BIP32 _bip32;

  CosmosWallet._(this._bip32, this._wallet)
      : assert(_bip32 != null),
        assert(_wallet != null);

  factory CosmosWallet.fromMnemonic(String mnemonic) {
    return CosmosWallet.fromSeed(bip39.mnemonicToSeed(mnemonic));
  }

  factory CosmosWallet.fromSeed(Uint8List seed) {
    final NetworkType network = cosmos;
    final bip32Wallet = bip32.BIP32.fromSeed(
        seed,
        bip32.NetworkType(
            bip32: bip32.Bip32Type(
                public: network.bip32.public, private: network.bip32.private),
            wif: network.wif));
    final hdWallet = HDWallet.fromSeed(seed, network: network);
    final cosmosWallet = CosmosWallet._(bip32Wallet, hdWallet);

    return cosmosWallet.derivePath(_derivationPath);
  }

  factory CosmosWallet.fromBase58(String xpub) {
    final NetworkType network = cosmos;
    final bip32Wallet = bip32.BIP32.fromBase58(
        xpub,
        bip32.NetworkType(
            bip32: bip32.Bip32Type(
                public: network.bip32.public, private: network.bip32.private),
            wif: network.wif));
    final hdWallet = HDWallet.fromBase58(xpub, network: network);
    final cosmosWallet = CosmosWallet._(bip32Wallet, hdWallet);

    return cosmosWallet.derivePath(_derivationPath);
  }

  @override
  String get address => _wallet.address;

  @override
  Uint8List get privateKey => _bip32.privateKey;

  // TODO: Convert pubKey to use Cosmos encoding
  @override
  Uint8List get publicKey => _bip32.publicKey;

  @override
  Uint8List sign(String message) {
    Uint8List messageHash = SHA256Digest().process(utf8.encode(message));
    return _bip32.sign(messageHash);
  }

  @override
  bool verify(String message, Uint8List signature) {
    Uint8List messageHash = SHA256Digest().process(utf8.encode(message));
    return _bip32.verify(messageHash, signature);
  }

  Uint8List get privKeyRaw => _bip32.privateKey;

  // Dirty fix in order to make the public key compatible with cosmos' amino encoded public keys
  Uint8List get pubKeyRaw =>
      Uint8List.fromList(_aminoPublicKeyPrefix + _bip32?.publicKey);

  @override
  wetonomy.Wallet derive(int index) {
    final bip32 = _bip32.derive(index);
    final wallet = _wallet.derive(index);
    return CosmosWallet._(bip32, wallet);
  }

  @override
  wetonomy.Wallet derivePath(String path) {
    final bip32 = _bip32.derivePath(path);
    final wallet = _wallet.derivePath(path);
    return CosmosWallet._(bip32, wallet);
  }
}
