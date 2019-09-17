import 'package:wetonomy/models/cosmos_integration/tendermint_subscribe_request.dart';

const String address = "cosmos1ketnxp9uylmkswayher3sx4qu49c6rdrvflj5v";

const String chainId = "strongforce-test-chain-16388";

const String webSocketUrl = "ws://ioan681.pagekite.me/websocket";

const String lightClientUrl = "http://08aeedec.ngrok.io/";

const TendermintSubscribeRequest subscribeMsg = TendermintSubscribeRequest(
    "2.0", "subscribe", "0", {"query": "tm.event = 'Tx'"});
