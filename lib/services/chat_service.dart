import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/model/chat_model.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:mobile/model/chat_user_model.dart';

class ChatService {
  static var client = http.Client();

  static Future<List<ChatModel>> getChatById(String id) async {
    await APIService.refreshToken();
    //print(id);
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.http(Config.apiURL, '${Config.getChatsAPI}/$id');

    var response = await http.get(url, headers: requestHeaders);

    print(response.body);
    var data = jsonDecode(response.body);
    if (response.body != '[]')
      {
        if (data['status'] == 'success') {
          return chatsFromJson(data['messages']);
        }
      }
    else
      {
        print('def');
      }

    return [];
  }
  static Future<List<ChatUserModel>> getAllChatedUsers() async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.http(Config.apiURL, Config.getAllChatUsersAPI);
    var response = await http.get(url, headers: requestHeaders);
    print(response.body);
    var data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      return chatUserFromJson(data['chattingUsers']);
    }
    return [];
  }
  static Future<bool> sendMessage(String message, String userId) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.http(Config.apiURL, '${Config.sendMessageAPI}/$userId');
    var response = await http.post(url, headers: requestHeaders, body: {
      'message': message,
    });
    print(response.body);
    return true;
}
}
