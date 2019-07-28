import 'package:wetonomy/models/action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/models/result.dart';
import 'package:wetonomy/repositories/strongforce_api_client.dart';

class StrongForceApiClientMock implements StrongForceApiClient {
  @override
  Future<Result> sendAction(Action action) async {
    await Future.delayed(Duration(seconds: 1));
    return Result.Success;
  }

  @override
  Future<Result> sendQuery(Query query) async {
    await Future.delayed(Duration(seconds: 1));
    return Result.Success;
  }
}
