import 'package:bitcoin_flutter/bitcoin_flutter.dart';

// TODO: Fix network type to be compatible with cosmos
final cosmos = new NetworkType(
    messagePrefix: '',
    bech32: 'cosmospub',
    bip32: new Bip32Type(public: 0x0488b21e, private: 0x0488ade4),
    pubKeyHash: 0x00,
    scriptHash: 0x05,
    wif: 0x80);
