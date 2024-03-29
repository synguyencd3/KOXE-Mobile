import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/model/chat_model.dart';
import 'package:mobile/services/shared_service.dart';

class ChatService {
  static var client = http.Client();

  static Future<List<ChatModel>> getChatById(String id) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.http(Config.apiURL, '${Config.getChatsAPI}/$id');

    var response = await http.get(url, headers: requestHeaders);

    print(response.body);
    var data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      return chatsFromJson(data['messages']);
    }
    return [];
  }
}