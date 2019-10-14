import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:json_annotation/json_annotation.dart';

class Uint8ListStringConverter implements JsonConverter<Uint8List, String> {
  const Uint8ListStringConverter();

  @override
  Uint8List fromJson(String json) {
    return Uint8List.fromList(hex.decode(json));
  }

  @override
  String toJson(Uint8List list) {
    return hex.encode(list);
  }
}
