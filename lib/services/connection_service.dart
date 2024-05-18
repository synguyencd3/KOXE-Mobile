import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:mobile/model/connection_model.dart';

class ConnectionService {
  static var client = http.Client();

  static Future<List<ConnectionModel>> getConnections() async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, Config.connectionsAPI);
    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return connectionsFromJson(data['connections']);
    }
    print('error');
    return [];
  }

  static Future<bool> createConnection(String postId, String processId) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, Config.connectionsAPI);
    var response = await http.post(url,
        headers: requestHeaders,
        body: jsonEncode({
          'postId': postId,
          'processId': processId,
        }));
    return response.statusCode == 201;
  }

  static Future<bool> updateStatusConnection(String status, String connectionId) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, '${Config.connectionsAPI}/$connectionId');
    var response = await http.patch(url,
        headers: requestHeaders,
        body: jsonEncode({
          'status': status,
        }));
    return response.statusCode == 200;
  }

  static Future<ConnectionModel> getConnectionDetail(String connectionId) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.https(Config.apiURL,'${Config.connectionsAPI}/$connectionId');
    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return ConnectionModel.fromJson(data['connection']);
    }
    return ConnectionModel();
  }
}
