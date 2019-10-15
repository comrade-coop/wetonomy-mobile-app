import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wetonomy/models/converters/uint8_list_string_converter.dart';

part 'cipher_parameters.g.dart';

@immutable
@JsonSerializable(nullable: false)
class CipherParameters {
  @JsonKey(name: 'iv')
  @Uint8ListStringConverter()
  final Uint8List initialVector;

  CipherParameters(this.initialVector) : assert(initialVector != null);

  factory CipherParameters.fromJson(Map<String, dynamic> json) =>
      _$CipherParametersFromJson(json);

  Map<String, dynamic> toJson() => _$CipherParametersToJson(this);
}
