import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wetonomy/models/cosmos_integration/tx/cosmos_msg.dart';
import 'package:wetonomy/models/cosmos_integration/tx/signatures.dart';


part 'cosmos_tx_value.g.dart';

@JsonSerializable(nullable: false)
class CosmosTxValue extends Equatable {
  final List<CosmosMsg> msg;

  final Map<String,dynamic> fee;

  final List<Signatures> signatures;

  final String memo;

  CosmosTxValue(this.msg, this.fee, this.signatures, this.memo): super([msg, fee, signatures, memo]);

  factory CosmosTxValue.fromJson(Map<String, dynamic> json) =>
      _$CosmosTxValueFromJson(json);

  Map<String, dynamic> toJson() => _$CosmosTxValueToJson(this);

  String toEncodedJson() => jsonEncode(this.toJson());
}