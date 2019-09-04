import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/services/contracts_api_client.dart';

class ContractsRepository {
  final ContractsApiClient _client;

  ContractsRepository(this._client) : assert(_client != null);

  Future<bool> sendAction(ContractAction action) async {
    final bool result = await _client.sendAction(action);
    return result;
  }

  Future<bool> sendQuery(Query query) async {
    final bool result = await _client.sendQuery(query);
    return result;
  }

  Future<Contract> getContractState(String address) async {
    return await _client.getContractState(address);
  }
}
