import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import './cosmos_tx_value.dart';

part 'cosmos_tx.g.dart';

@JsonSerializable(nullable: false)
class CosmosTx extends Equatable {
  final String type;
  final CosmosTxValue value;

  CosmosTx(this.type, this.value)
  : super([type]);

  factory CosmosTx.fromJson(Map<String, dynamic> json) =>
      _$CosmosTxFromJson(json);

  Map<String, dynamic> toJson() => _$CosmosTxToJson(this);

  String toEncodedJson() => jsonEncode(this.toJson());
}