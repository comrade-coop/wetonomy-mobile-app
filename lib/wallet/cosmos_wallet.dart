import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter/foundation.dart';
import "package:pointycastle/digests/sha256.dart";
import 'package:pointycastle/export.dart' as pointyCastle;
import 'package:wetonomy/wallet/key_derivator.dart';
import 'package:wetonomy/wallet/network.dart';
import 'package:wetonomy/wallet/random_bridge.dart';
import 'package:wetonomy/wallet/scrypt_key_derivator.dart';
import 'package:wetonomy/wallet/wallet.dart' as wetonomy;

class CosmosWallet implements wetonomy.Wallet {
  static final String derivationPath = 'm/44\'/118\'/0\'/0/0';
  static final List<int> _aminoPublicKeyPrefix = [235, 90, 233, 135, 33];

  final HDWallet _wallet;
  final bip32.BIP32 _bip32;
  final Uint8List password;
  final Uint8List iv;
  KeyDerivator _keyDerivator;

  CosmosWallet._(this._bip32, this._wallet, this.password, this.iv,
      {KeyDerivator keyDerivator})
      : assert(_bip32 != null),
        assert(_wallet != null),
        assert(iv != null) {
    if (keyDerivator == null) {
      keyDerivator = ScryptKeyDerivator.defaultParams();
    }
    this._keyDerivator = keyDerivator;
  }

  factory CosmosWallet.fromMnemonic(String mnemonic, Uint8List password) {
    return CosmosWallet.fromSeed(bip39.mnemonicToSeed(mnemonic), password);
  }

  factory CosmosWallet.fromSeed(Uint8List seed, Uint8List password) {
    final random = RandomBridge(Random.secure());
    final iv = random.nextBytes(16);

    final NetworkType network = cosmos;
    final bip32Wallet = bip32.BIP32.fromSeed(
        seed,
        bip32.NetworkType(
            bip32: bip32.Bip32Type(
                public: network.bip32.public, private: network.bip32.private),
            wif: network.wif));
    final hdWallet = HDWallet.fromSeed(seed, network: network);
    final cosmosWallet = CosmosWallet._(bip32Wallet, hdWallet, password, iv,
        keyDerivator: ScryptKeyDerivator.defaultParams());

    return cosmosWallet._derivePath(derivationPath);
  }

  factory CosmosWallet.fromBase58(
      String xPub, Uint8List password, Uint8List iv) {
    final NetworkType network = cosmos;
    final bip32Wallet = bip32.BIP32.fromBase58(
        xPub,
        bip32.NetworkType(
            bip32: bip32.Bip32Type(
                public: network.bip32.public, private: network.bip32.private),
            wif: network.wif));
    final hdWallet = HDWallet.fromBase58(xPub, network: network);

    final random = RandomBridge(Random.secure());
    final iv = random.nextBytes(16);

    return CosmosWallet._(bip32Wallet, hdWallet, password, iv);
  }

  factory CosmosWallet.fromJson(String encoded, String password) {
    final data = json.decode(encoded);

    final crypto = data['crypto'];
    if (crypto == null) {
      _throwWalletException('crypto', encoded);
    }

    final String kdf = crypto['kdf'];
    if (kdf == null) {
      _throwWalletException('kdf', encoded);
    }

    final encryptedBase58 = hex.decode(crypto['ciphertext']);
    if (encryptedBase58 == null) {
      _throwWalletException('ciphertext', encoded);
    }

    final List<int> mac = crypto['mac']?.cast<int>()?.toList();
    if (mac == null) {
      _throwWalletException('mac', encoded);
    }

    final cipher = crypto['cipher'];
    if (cipher == null) {
      _throwWalletException('cipher', encoded);
    }

    final cipherParams = crypto['cipherparams'];
    if (cipherParams == null) {
      _throwWalletException('cipherparams', encoded);
    }

    final ivEncoded = cipherParams['iv'];
    if (ivEncoded == null) {
      _throwWalletException('iv', encoded);
    }
    final iv = Uint8List.fromList(hex.decode(ivEncoded));

    KeyDerivator derivator;

    switch (kdf) {
      case 'scrypt':
        final Map<String, dynamic> params = crypto['kdfparams'];
        derivator = ScryptKeyDerivator(
          params['dklen'] as int,
          params['n'] as int,
          params['r'] as int,
          params['p'] as int,
          Uint8List.fromList(hex.decode(params['salt'])),
        );
        break;
      default:
        throw ArgumentError(
            'Wallet file uses $kdf as key derivation function, which is not supported.');
    }

    final Uint8List encodedPassword = Uint8List.fromList(utf8.encode(password));
    final Uint8List derivedKey = derivator.deriveKey(encodedPassword);
    final aesKey = Uint8List.fromList(derivedKey.sublist(0, 16));

    final List<int> derivedMac = _generateMac(derivedKey, encryptedBase58);
    if (!listEquals<int>(mac, derivedMac)) {
      throw ArgumentError(
          'Could not unlock wallet file. You either supplied the wrong password or the file is corrupted');
    }

    if (cipher != 'aes-128-ctr') {
      throw ArgumentError(
          'Wallet file uses ${crypto["cipher"]} as cipher, but only aes-128-ctr is supported.');
    }

    final aes = _initCipher(aesKey, iv);

    final Uint8List base58 = aes.process(Uint8List.fromList(encryptedBase58));
    return CosmosWallet.fromBase58(utf8.decode(base58), encodedPassword, iv);
  }

  static void _throwWalletException(String property, String walletJson) {
    throw ArgumentError(
        '$property property is null. Provided wallet json: \n' + walletJson);
  }

  @override
  String get address => _wallet.address;

  @override
  Uint8List get privateKey => _bip32.privateKey;

  // TODO: Convert pubKey to use Cosmos encoding
  // Dirty fix in order to make the public key compatible with cosmos' amino encoded public keys
  @override
  Uint8List get publicKey =>
      Uint8List.fromList(_aminoPublicKeyPrefix + _bip32?.publicKey);

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

  @override
  wetonomy.Wallet derive(int index) {
    final bip32 = _bip32.derive(index);
    final wallet = _wallet.derive(index);
    return CosmosWallet._(bip32, wallet, password, iv);
  }

  wetonomy.Wallet _derivePath(String path) {
    final bip32 = _bip32.derivePath(path);
    final wallet = _wallet.derivePath(path);
    return CosmosWallet._(bip32, wallet, password, iv);
  }

  @override
  String toJson() {
    final Uint8List cipher = _encryptPrivateKey();

    final jsonMap = {
      'crypto': {
        'cipher': 'aes-128-ctr',
        'cipherparams': {'iv': hex.encode(iv)},
        'ciphertext': hex.encode(cipher),
        'kdf': _keyDerivator.name,
        'kdfparams': _keyDerivator.encode(),
        'mac': _generateMac(_keyDerivator.deriveKey(password), cipher)
      }
    };

    return json.encode(jsonMap);
  }

  Uint8List _encryptPrivateKey() {
    final derived = _keyDerivator.deriveKey(password);
    final aesKey = Uint8List.view(derived.buffer, 0, 16);

    final aes = _initCipher(aesKey, iv);
    return aes.process(Uint8List.fromList(utf8.encode(toBase58())));
  }

  static pointyCastle.CTRStreamCipher _initCipher(
      Uint8List aesKey, Uint8List iv) {
    return pointyCastle.CTRStreamCipher(pointyCastle.AESFastEngine())
      ..init(false,
          pointyCastle.ParametersWithIV(pointyCastle.KeyParameter(aesKey), iv));
  }

  static List<int> _generateMac(List<int> dk, List<int> cipherText) {
    final List<int> macBody = <int>[]
      ..addAll(dk.sublist(16, 32))
      ..addAll(cipherText);
    return pointyCastle.SHA3Digest(256)
        .process(Uint8List.fromList(macBody))
        .toList();
  }

  @override
  String toBase58() => _bip32.toBase58();
}
