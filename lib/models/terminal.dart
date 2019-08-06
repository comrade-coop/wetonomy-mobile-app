import 'package:flutter/foundation.dart';

@immutable
class Terminal {
  final String url;

  Terminal(this.url) : assert(url != null);
}
