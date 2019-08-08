import 'package:flutter/foundation.dart';

@immutable
class TerminalData {
  final String url;
  final List<String> contractAddresses;

  TerminalData(this.url, this.contractAddresses)
      : assert(url != null),
        assert(contractAddresses != null);
}
