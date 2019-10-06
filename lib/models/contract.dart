import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract.g.dart';

@JsonSerializable(nullable: false)
class Contract extends Equatable {
  final String address;

  final Map<String, dynamic> state;

  Contract(this.address, this.state)
      : assert(address != null),
        assert(state != null),
        super([address, state]);

  factory Contract.fromJson(Map<String, dynamic> json) =>
      _$ContractFromJson(json);

  Map<String, dynamic> toJson() => _$ContractToJson(this);
}
