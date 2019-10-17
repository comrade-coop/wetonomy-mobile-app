import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signatures.g.dart';

@JsonSerializable(nullable: false)
class Signatures extends Equatable {
  final Map<String, dynamic> pub_key;

  final String signature;

  Signatures(this.pub_key, this.signature): super([pub_key, signature]);

  factory Signatures.fromJson(Map<String, dynamic> json) =>
      _$SignaturesFromJson(json);

  Map<String, dynamic> toJson() => _$SignaturesToJson(this);

  String toEncodedJson() => jsonEncode(this.toJson());
}