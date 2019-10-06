import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signatures.g.dart';

@JsonSerializable(nullable: false)
class Signatures extends Equatable {
  final String signature;

  final Map<String, dynamic> pub_key;

  Signatures(this.signature, this.pub_key): super([signature, pub_key]);

  factory Signatures.fromJson(Map<String, dynamic> json) =>
      _$SignaturesFromJson(json);

  Map<String, dynamic> toJson() => _$SignaturesToJson(this);

  String toEncodedJson() => jsonEncode(this.toJson());
}