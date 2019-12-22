import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'terminal_data.g.dart';

@immutable
@JsonSerializable(nullable: false)
class TerminalData extends Equatable {
  final String url;
  final String name;
  final bool nativeTerminal;

  TerminalData(this.url, this.name,{this.nativeTerminal=false})
      : assert(url != null),
        assert(name != null),
        assert(nativeTerminal != null),
        super([url, name, nativeTerminal]);

  factory TerminalData.fromJson(Map<String, dynamic> json) =>
      _$TerminalDataFromJson(json);

  Map<String, dynamic> toJson() => _$TerminalDataToJson(this);
}
