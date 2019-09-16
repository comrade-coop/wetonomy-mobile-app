import 'dart:async';
import 'dart:convert';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_event.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/models/cosmos_integration/action_request.dart';
import 'package:wetonomy/models/cosmos_integration/base_request.dart';
import 'package:wetonomy/services/contracts_api_client.dart';
import 'package:wetonomy/services/mock_env.dart';
import 'package:http/http.dart' as http;
import 'package:wetonomy/models/contract.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'package:wetonomy/models/cosmos_integration/tendermint_response.dart';
import 'package:wetonomy/models/cosmos_integration/tendermint_subscribe_request.dart';



class StrongForceApiClientCosmos implements ContractsApiClient {
  static int count = 0;
  
  IOWebSocketChannel channel;
  StreamController<ContractStateUpdateEvent> contractsEventsStream;

  // String baseURL = "http://127.0.0.1:1317/";
  String baseURL = lightClientUrl;
  int seq = 2;

  StrongForceApiClientCosmos(){
    channel = IOWebSocketChannel.connect(webSocketUrl);
    contractsEventsStream = new StreamController<ContractStateUpdateEvent>();
    _subscribeForEvents();
  }
   
  @override
  Future<Map<String,dynamic>> sendAction(ContractAction action) async {
    String actionUrl = "strongforce/contract/action";
    var url = baseURL + actionUrl;
    
    var bytes = utf8.encode(jsonEncode(action.toJson()));
    var encodedAction = Base64Codec().encode(bytes);

    var account = await _getAccontSequence(address);

    var base = BaseRequest(address, account["sequence"], chainId, account["account_number"]);
    var request = ActionRequest(base, 'A', encodedAction);

    var encoded = jsonEncode(request);
    var response = await http.post(url, body: encoded);
    var body = jsonDecode(response.body);
    body["error"]["code"]+=seq;
    seq++;
    return body["error"];
  }

  @override
  Future<Map<String,dynamic>> sendQuery(Query query) async {
    var url = baseURL + query.url;
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    return body["result"];
  }

  Future<Map<String, dynamic>> _getAccontSequence(String address) async {
    var url = baseURL + "auth/accounts/" + address;
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    return body["result"]["value"];
  }

  void _subscribeForEvents() {
    TendermintSubscribeRequest msg = subscribeMsg;
    channel.sink.add(jsonEncode(msg));
    channel.stream.listen(
      (message){
        var decoded = jsonDecode(message);
        var x = TendermintResponse.fromJson(decoded);
        if(x.result.events != null){
          var addresses = x.result.events["ContractStateUpdate.Address"];
          var states = x.result.events["ContractStateUpdate.State"];
          addresses.asMap().forEach((index, value) => { _sendContractStateUpdateEvent(addresses[index], states[index])});
        }
        print(message);
      },
      onError: (error, StackTrace stackTrace){
        print(error);
        // error handling
      },
      onDone: (){
        throw("Unexpected close");
        // communication has been closed 
      },
      cancelOnError: false);
  }

  void _sendContractStateUpdateEvent(String address, String state){
    var contract = Contract(address, jsonDecode(state));
    contractsEventsStream.add(ContractStateUpdateEvent(contract));
  }

  @override
  StreamController<ContractStateUpdateEvent> getContractsEventsStream() {
    return contractsEventsStream;
  }
}
