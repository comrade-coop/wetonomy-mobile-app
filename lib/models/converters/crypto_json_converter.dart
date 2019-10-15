import 'package:json_annotation/json_annotation.dart';
import 'package:wetonomy/models/wallet/crypto.dart';

class CryptoJsonConverter
    implements JsonConverter<Crypto, Map<String, dynamic>> {
  const CryptoJsonConverter();

  @override
  fromJson(Map<String, dynamic> json) {
    return Crypto.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Crypto crypto) {
    return crypto.toJson();
  }
}
