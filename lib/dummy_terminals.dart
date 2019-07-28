import 'dart:convert';

const String dummyQueryTerminalContent = '''
<!DOCTYPE html><html>
<head><title>Webview example</title></head>
<body>
<button onclick="sendMessageToNative()">
Send Query Request
</button>
</ul>

<script>

function sendMessageToNative() {
  StrongForce.postMessage("New query");
}

function receiveMessageFromNative(msg) {
  document.body.innerHTML +='<p>Message received from native code: ' + msg + '</p>';
}

</script>
</body>
</html>
''';

final String dummyQueryTerminalUrl =
    'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(dummyQueryTerminalContent))}';
