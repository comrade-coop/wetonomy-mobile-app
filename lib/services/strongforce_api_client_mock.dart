import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/services/strongforce_api_client.dart';

class StrongForceApiClientMock implements StrongForceApiClient {
  static int count = 0;

  @override
  Future<bool> sendAction(ContractAction action) async {
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }

  @override
  Future<bool> sendQuery(Query query) async {
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }

  @override
  Future<Contract> getContractState(String address) async {
    await Future.delayed(Duration(milliseconds: 500));
    return Contract('0x0', {'count': count++});
  }
}
