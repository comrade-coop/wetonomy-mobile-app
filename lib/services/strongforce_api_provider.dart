import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/query.dart';

class StrongForceApiProvider {
  // ignore: missing_return
  Future<bool> sendAction(ContractAction action) async {}

  // ignore: missing_return
  Future<bool> sendQuery(Query query) async {}

  // ignore: missing_return
  Future<Contract> getContractState(String address) async {}
}
