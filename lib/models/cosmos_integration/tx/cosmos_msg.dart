import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cosmos_msg.g.dart';

@JsonSerializable(nullable: false)
class CosmosMsg extends Equatable {
  final String type;
  final Map<String, dynamic> value;

  CosmosMsg(this.type, this.value)
  : super([type]);

  factory CosmosMsg.fromJson(Map<String, dynamic> json) =>
      _$CosmosMsgFromJson(json);

  Map<String, dynamic> toJson() => _$CosmosMsgToJson(this);

  String toEncodedJson() => jsonEncode(this.toJson());
}