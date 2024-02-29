import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/model/login_request_model.dart';
import 'package:mobile/model/login_response_model.dart';
import 'package:mobile/model/news_model.dart';
import 'package:mobile/model/register_response_model.dart';
import 'package:mobile/services/shared_service.dart';

import '../config.dart';
import '../model/register_request_model.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequest model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiURL, Config.loginAPI);

    print(requestHeaders);
    print(jsonEncode(model.toJson()));

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    print(response.statusCode);
    print(loginResponseJson(response.body).message);
    print(loginResponseJson(response.body).data);
    if (response.statusCode == 200) {
      // Shared
      //await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponse> register(RegisterRequest model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseJson(response.body);
  }

  static Future<List<NewsResponse>> getNews() async {
    final Map<String, String> param = <String, String>{
      'q': 'f1',
      'language': 'en',
      'pageSize': '4',
      'apiKey': Config.apiKey
    };

    var url = Uri.https(Config.newsURL, Config.newsAPi, param);

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return newsFromJson(data['articles']);
    }
    return [];
  }
}
