import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/models/models.dart';

part 'contracts_state.g.dart';

@immutable
@JsonSerializable(nullable: false)
class ContractsState extends Equatable {
  final List<Contract> contracts;

  ContractsState([this.contracts = const []]) : super(contracts);

  factory ContractsState.fromJson(Map<String, dynamic> json) =>
      _$ContractsStateFromJson(json);

  Map<String, dynamic> toJson() => _$ContractsStateToJson(this);

  String toEncodedJson() => jsonEncode(this.toJson());
}
