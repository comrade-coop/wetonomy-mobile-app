import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/models/result.dart';
import 'package:wetonomy/repositories/strongforce_api_client.dart';

class StrongForceRepository {
  final StrongForceApiClient client;

  StrongForceRepository(this.client) : assert(client != null);

  Future<Result> sendAction(ContractAction action) async {
    final Result result = await client.sendAction(action);
    return result;
  }

  Future<Result> sendQuery(Query query) async {
    final Result result = await client.sendQuery(query);
    return result;
  }
}
