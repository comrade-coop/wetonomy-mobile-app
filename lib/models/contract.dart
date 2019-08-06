class Contract {
  final String state;
  final String address;

  Contract(this.address, this.state) : assert(state != null);
}
