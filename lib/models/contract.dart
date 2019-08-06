import 'package:equatable/equatable.dart';

class Contract extends Equatable {
  final String state;
  final String address;

  Contract(this.address, this.state)
      : assert(state != null),
        assert(address != null),
        super([address, state]);
}
