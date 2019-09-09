import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'terminal_data.g.dart';

@immutable
@JsonSerializable(nullable: false)
class TerminalData extends Equatable {
  final String url;
  final String name;

  TerminalData(this.url, this.name)
      : assert(url != null),
        assert(name != null),
        super([url, name]);

  factory TerminalData.fromJson(Map<String, dynamic> json) =>
      _$TerminalDataFromJson(json);

  Map<String, dynamic> toJson() => _$TerminalDataToJson(this);

  String toEncodedJson() => jsonEncode(this.toJson());
}
