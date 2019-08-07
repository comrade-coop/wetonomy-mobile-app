import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/repositories/strongforce_api_client.dart';

class StrongForceApiClientMock implements StrongForceApiClient {
  @override
  Future<bool> sendAction(ContractAction action) async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

  @override
  Future<bool> sendQuery(Query query) async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }
}
