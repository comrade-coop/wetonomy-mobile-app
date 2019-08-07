import 'package:equatable/equatable.dart';

class Contract extends Equatable {
  final String state;

  Contract(this.state)
      : assert(state != null),
        super([state]);
}
