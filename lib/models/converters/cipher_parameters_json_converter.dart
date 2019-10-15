import 'package:json_annotation/json_annotation.dart';
import 'package:wetonomy/models/wallet/cipher_parameters.dart';

class CipherParametersJsonConverter
    implements JsonConverter<CipherParameters, Map<String, dynamic>> {
  const CipherParametersJsonConverter();

  @override
  CipherParameters fromJson(Map<String, dynamic> json) {
    return CipherParameters.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(CipherParameters parameters) {
    return parameters.toJson();
  }
}
