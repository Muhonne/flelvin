import 'package:web_socket_channel/io.dart';

class SocketApi {
  String apiUrl = 'wss://api.mountkelvin.com';
  IOWebSocketChannel channel;

  SocketApi(String siteKey) {
    print("connectin!");
    this.channel = IOWebSocketChannel.connect(this.apiUrl);
    this.channel.sink.add(data)
    print("connected!");
    this.channel.stream.listen((message) {
      print("MESSAGE");
    });
  }
}
