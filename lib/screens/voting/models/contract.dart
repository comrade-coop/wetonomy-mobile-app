import 'contract_action.dart';

class Contract {
  final String address;
  final String name;
  final String type;
  final List<ContractAction> actions;
  Contract(this.address, this.name, this.type, this.actions);
}
