import 'package:wetonomy/models/cosmos_integration/tendermint_subscribe_request.dart';

const String address = "cosmos10cww2j7uzzcderauhtuae54069rg76ygrynyes";

const String mnemonic =  "laundry awake fit famous loop rubber lazy rotate pool render vapor asset change security eight hero price bless mystery manual sad fresh axis party ";

const String chainId = "strongforce-test-chain-26915";

const String webSocketUrl = "ws://0.0.0.0:26657/websocket";//"ws://ioan681.pagekite.me/websocket";

const String lightClientUrl = "http://127.0.0.1:1317/";//"http://08aeedec.ngrok.io/";

const TendermintSubscribeRequest subscribeMsg = TendermintSubscribeRequest(
    "2.0", "subscribe", "0", {"query": "tm.event = 'Tx'"});
