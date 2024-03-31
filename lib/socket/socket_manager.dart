import 'dart:async';
import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:mobile/config.dart';

class SocketManager {
  static IO.Socket? _socket;
  static StreamController<Map<String,dynamic>> _messageController =StreamController.broadcast();
  static Stream<Map<String,dynamic>> get messageStream => _messageController.stream;


  static Future<void> initSocket(String userId, String salonId, Function callback) async {
    if (_socket != null && _socket!.connected) {
      _socket!.disconnect();
    }
    if (salonId == '') {
      _socket = IO.io(
          'http://' + Config.apiURL,
          IO.OptionBuilder().setTransports(['websocket']).setQuery({
            'userId': userId,
          }).build());
    } else {
      _socket = IO.io(
          'http://' + Config.apiURL,
          IO.OptionBuilder().setTransports(['websocket']).setQuery({
            'userId': userId,
            'salonId': salonId,
          }).build());
    }
    _socket!.connect();
    print('connected');
  ;
    _socket!.on('newMessage', (data) {
      _messageController.add(data);
    });
    _socket!.on('getOnlineUsers', (data) {
      callback(data);
    });
  }

  // disconnect socket
  static void disconnectSocket() {
    _socket!.disconnect();
    print('disconnect');
  }

}
