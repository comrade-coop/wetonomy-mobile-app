import 'package:flutter/foundation.dart';

@immutable
class TerminalData {
  final String url;

  TerminalData(this.url) : assert(url != null);
}
