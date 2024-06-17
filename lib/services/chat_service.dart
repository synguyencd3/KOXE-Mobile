import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/model/chat_model.dart';
import 'package:mobile/model/user_search_model.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:mobile/model/chat_user_model.dart';
import 'package:http_parser/http_parser.dart';

class ChatService {
  static var client = http.Client();

  static Future<List<ChatModel>> getChatById(String id) async {
    await APIService.refreshToken();
    //print(id);
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, '${Config.getChatsAPI}/$id');

    var response = await http.get(url, headers: requestHeaders);

    //print(response.body);
    var data = jsonDecode(response.body);
    if (response.body != '[]') {
      if (data['status'] == 'success' && data['messages'] != null) {
        return chatsFromJson(data['messages']);
      }
    } else {
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
    var url = Uri.https(Config.apiURL, Config.getAllChatUsersAPI);
    var response = await http.get(url, headers: requestHeaders);
    print(response.body);
    if (response.body == '[]') {
      return [];
    }
    var data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      return chatUserFromJson(data['chattingUsers']);
    }
    return [];
  }

  static Future<bool> sendMessage(
      String message, String userId, List<String> images) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, '${Config.sendMessageAPI}/$userId');
    http.MultipartRequest request = new http.MultipartRequest("POST", url);
    request.headers.addAll(requestHeaders);
    if (message != '') {
      request.fields['message'] = message;
    }

    if (images.isNotEmpty) {
      for (var imagePath in images) {
        var multipartFile = await http.MultipartFile.fromPath(
          'imgList',
          imagePath,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(multipartFile);
      }
    }

    var response = await request.send();

    return response.statusCode == 201;
  }

  static Future<List<UserSearchModel>> searchUser(String search) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var queryParameters = {
      'q': search,
    };
    var url = Uri.https(Config.apiURL, Config.searchUserAPI, queryParameters);
    var response = await http.get(url, headers: requestHeaders);
    var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return userSearchFromJson(data);
  }
    return [];
  }
}
