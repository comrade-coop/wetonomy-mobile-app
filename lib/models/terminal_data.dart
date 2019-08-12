import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class TerminalData {
  final String url;
  final List<String> contractAddresses;
  final IconData icon;

  TerminalData(this.url, this.contractAddresses, {this.icon})
      : assert(url != null),
        assert(contractAddresses != null);
}
