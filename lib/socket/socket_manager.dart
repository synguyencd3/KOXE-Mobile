import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:mobile/config.dart';

class SocketManager {
  static IO.Socket? socket;

  static Future<void> initSocket(String userId, String salonId) async {
      if (salonId == '') {
        socket = IO.io("http://localhost:5000", <String, dynamic>{
          'query': {
            'userId': userId,
          },
        });
      } else {
        socket = IO.io("http://localhost:5000", <String, dynamic>{
          'query': {
            'userId': userId,
            'salonId': salonId,
          },
        });
    }

  }

  static bool isConnected() {
    if (socket == null) {
      return false;
    } else {
      return socket!.connected;
    }
  }
}
