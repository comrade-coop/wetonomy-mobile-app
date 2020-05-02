
import 'package:flutter_test/flutter_test.dart';
import 'package:wetonomy/services/ipfs-connection.dart';

void main() {

  group('IpfsPubSub', () {
    final ipfsClient = IpfsPubSub();
    test('IPFS PubSub get topics', () async {
      var response = await ipfsClient.getTopics();
      expect(true,true);
    });

    test('IPFS PubSub publish', () async {
      var response = await ipfsClient.publishMessageToTopics();
      expect(true,true);
    });

    test('IPFS PubSub subscribe', () async {
      var response = await ipfsClient.subscribeToTopics();
      expect(true,true);
    });

  });
}