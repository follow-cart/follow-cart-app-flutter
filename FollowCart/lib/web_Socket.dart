import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RobotController {
  static final RobotController _singleton = RobotController._internal();

  late final WebSocketChannel channel;

  factory RobotController() {
    return _singleton;
  }

  RobotController._internal() {
    channel = IOWebSocketChannel.connect(Uri.parse("ws://localhost:9090"));
    channel.stream.listen((message) {
      print("Received from server: $message");
    }, onError: (error) {
      print("WebSocket error: $error");
    }, onDone: () {
      print("WebSocket connection closed");
    });
  }

  void sendCommand(String command, double x, double y, double theta) {
    var message = {
      'op': 'publish',
      'topic': '/android_commands',
      'msg': {
        'data': jsonEncode({
          'command': command,
          'x': x,
          'y': y,
          'theta': theta
        })
      }
    };
    channel.sink.add(jsonEncode(message));
  }

  void sendLeaderCommand(String command) {
    var message = jsonEncode({
      'op': 'publish',
      'topic': '/Leader/call_message',
      'msg': {'data': command}
    });
    channel.sink.add(message);
    print("Command Leader sent: $message");
  }

  void sendRearCommand(String command) {
    var message = jsonEncode({
      'op': 'publish',
      'topic': '/Rear/call_message',
      'msg': {'data': command}
    });
    channel.sink.add(message);
    print("Command Rear sent: $message");
  }

  void sendLeaderDriveCommand(String command) {
    var message = jsonEncode({
      'op': 'publish',
      'topic': '/Leader/drive_message',
      'msg': {'data': command}
    });
    channel.sink.add(message);
    print("Command Leader Drive sent: $message");
  }

  void sendPositionCommand(String command) {
    var message = jsonEncode({
      'op': 'publish',
      'topic': '/Rear/position',
      'msg': {'data': command}
    });
    channel.sink.add(message);
    print("Command Position sent: $message");
  }

  void dispose() {
    channel.sink.close();
  }
}