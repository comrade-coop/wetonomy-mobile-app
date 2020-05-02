import 'dart:convert';

import 'package:http/http.dart' as http;

class IpfsPubSub {

  final String _baseURL = "http://127.0.0.1:5001/api/v0/pubsub/";

  IpfsPubSub() {
  }

  Future<Map<String, dynamic>> getTopics() async {
    final String url = _baseURL + 'ls';
    final http.Response response = await http.get(url);
    final dynamic body = jsonDecode(response.body);
    return body;
  }

  Future<String> publishMessageToTopics() async {
    final String url = _baseURL + 'pub?arg=foo&arg=ketappp';
    final http.Response response = await http.post(url);
    // final dynamic body = jsonDecode(response.body);
    return response.body;
  }

  Future<String> subscribeToTopics() async {
    final String url = _baseURL + 'sub?arg=foo&discover=false';
    final http.Response response = await http.post(url);
    // final dynamic body = jsonDecode(response.body);
    return response.body;
  }

}

