import 'dart:async';
import 'dart:convert';
import 'package:wetonomy/models/action.dart';
import 'package:wetonomy/models/action_result.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/models/cosmos_integration/action_request.dart';
import 'package:wetonomy/models/cosmos_integration/base_request.dart';
import 'package:wetonomy/models/query_result.dart';
import 'package:wetonomy/services/clients/contracts_api_client.dart';
import 'package:wetonomy/services/mock_env.dart';
import 'package:http/http.dart' as http;
import 'package:wetonomy/models/contract.dart';

import 'package:web_socket_channel/io.dart';

import 'package:wetonomy/models/cosmos_integration/tendermint_response.dart';
import 'package:wetonomy/models/cosmos_integration/tendermint_subscribe_request.dart';

class StrongForceApiClientCosmos implements ContractsApiClient {
  static int count = 0;

  IOWebSocketChannel _channel;
  StreamController<Contract> _contractsEventsStream;

  // String baseURL = "http://127.0.0.1:1317/";
  final String _baseURL = lightClientUrl;
  int _seq = 2;

  StrongForceApiClientCosmos() {
    _channel = IOWebSocketChannel.connect(webSocketUrl);
    _contractsEventsStream = StreamController<Contract>.broadcast();
    _subscribeForEvents();
  }

  @override
  Future<ActionResult> sendAction(Action action) async {
    final String actionUrl = 'strongforce/contract/action';
    final String url = _baseURL + actionUrl;

    final List<int> bytes = utf8.encode(jsonEncode(action.toJson()));
    final String encodedAction = Base64Codec().encode(bytes);

    final Map<String, dynamic> account = await _getAccountSequence(address);

    final BaseRequest base = BaseRequest(
        address, account['sequence'], chainId, account['account_number']);
    final ActionRequest request = ActionRequest(base, 'A', encodedAction);

    final String encoded = jsonEncode(request);
    final http.Response response = await http.post(url, body: encoded);
    dynamic body = jsonDecode(response.body);
    body['error']['code'] += _seq;
    _seq++;
    return ActionResult(body['error'], action);
  }

  @override
  Future<QueryResult> sendQuery(Query query) async {
    final String url = _baseURL + query.contractAddress;
    final http.Response response = await http.get(url);
    final dynamic body = jsonDecode(response.body);
    return QueryResult(body['result'], query);
  }

  Future<Map<String, dynamic>> _getAccountSequence(String address) async {
    final String url = _baseURL + 'auth/accounts/' + address;
    final http.Response response = await http.get(url);
    final dynamic body = jsonDecode(response.body);
    return body['result']['value'];
  }

  void _subscribeForEvents() {
    TendermintSubscribeRequest msg = subscribeMsg;
    _channel.sink.add(jsonEncode(msg));
    _channel.stream.listen((message) {
      final dynamic decoded = jsonDecode(message);
      final TendermintResponse x = TendermintResponse.fromJson(decoded);
      if (x.result.events != null) {
        final dynamic addresses =
            x.result.events['ContractStateUpdate.Address'];
        final dynamic states = x.result.events['ContractStateUpdate.State'];
        addresses.asMap().forEach((index, value) =>
            _sendContractStateUpdateEvent(addresses[index], states[index]));
      }
      print(message);
    }, onError: (error, StackTrace stackTrace) {
      print(error);
      // error handling
    }, onDone: () {
//      throw ('Unexpected close');
      // communication has been closed
    }, cancelOnError: false);
  }

  void _sendContractStateUpdateEvent(String address, String state) {
    final contract = Contract(address, jsonDecode(state));
    _contractsEventsStream.add(contract);
  }

  @override
  Stream<Contract> get contractsEventsStream => _contractsEventsStream.stream;
}
