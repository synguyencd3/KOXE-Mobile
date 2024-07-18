import 'dart:async';
import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:mobile/config.dart';

class SocketManager {
  static final SocketManager _singleton = SocketManager._internal();

  factory SocketManager() {
    return _singleton;
  }

  SocketManager._internal();

  IO.Socket? _socket;
  StreamController<Map<String, dynamic>> _messageController =
      StreamController.broadcast();

  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;
  StreamController<String> _notificationController =
      StreamController.broadcast();

  Stream<String> get notificationStream => _notificationController.stream;

  StreamController<List<dynamic>> _onlineUsersController =
      StreamController.broadcast();

  Stream<List<dynamic>> get onlineUsersStream => _onlineUsersController.stream;
  List<dynamic> onlineUsers = [];
  Future<void> initSocket(
      String userId, String salonId, Function callback) async {
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
    if (_messageController.isClosed)
    {
      _messageController = StreamController.broadcast();
    }
    if (_notificationController.isClosed)
    {
      _notificationController = StreamController.broadcast();
    }
    if (_onlineUsersController.isClosed)
    {
      _onlineUsersController = StreamController.broadcast();
    }
    _socket!.on('newMessage', (data) {
      //print(data);
      _messageController.add(data);
    });
    _socket!.on('notification', (data) {
      print(data);
      _notificationController.add(data);

    });
    _socket!.on('getOnlineUsers', (data) {
     onlineUsers = data;
      _onlineUsersController.add(onlineUsers);
      //print(onlineUsers);
    });

  }

  // disconnect socket
  void disconnectSocket() {
    if (_socket != null && _socket!.connected) {
      _socket!.disconnect();
      if (!_messageController.isClosed) {
        _messageController.close();
      }
      if (!_notificationController.isClosed) {
        _notificationController.close();
      }
      if (!_onlineUsersController.isClosed) {
        _onlineUsersController.close();
      }

    }
  }

  bool isSocketConnected() {
    return _socket!.connected;
  }
}
