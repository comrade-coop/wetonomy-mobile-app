import 'dart:convert';

const String dummyQueryTerminalContent = '''
<!DOCTYPE html>
<html>

<head>
  <title>
    Webview example
  </title>
</head>

<body>

  <button onclick="sendMessageToNative()">
    Send Action
  </button>


  <script>

    function sendMessageToNative() {
      const action = {
        target: '0x00000000000000000000',
        actionName: 'CreateAchievement',
        parameters: []
      };
      \StrongForceChannel.postMessage(JSON.stringify(action));
    }
    
    function StrongForce__receiveMessageFromNative(msg) {
      document.body.innerHTML +='<p>Message received from native code: ' + msg + '</p>';
    }

  </script>

</body>

</html>
''';

final String dummyQueryTerminalUrl =
    'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(dummyQueryTerminalContent))}';
