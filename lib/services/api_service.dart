import 'dart:convert';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/login_request_model.dart';
import 'package:mobile/model/login_response_model.dart';
import 'package:mobile/model/articles_model.dart';
import 'package:mobile/model/register_response_model.dart';
import 'package:mobile/services/shared_service.dart';

import '../config.dart';
import '../model/register_request_model.dart';
import 'package:mobile/model/user_model.dart';
import 'package:http_parser/http_parser.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequest model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    print(url);
    print(requestHeaders);
    print(jsonEncode(model.toJson()));

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    print('request success');
    print(jsonDecode(response.body));
    var responsemodel = loginResponseJson(response.body);
    if (responsemodel.status == "success") {
      // API ko chạy trên nền web đc, uncomment khi chạy emulator
      await SharedService.setLoginDetails(loginResponseJson(response.body));
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

  static Future<List<Articles>> getArticles() async {
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
      return articlesFromJson(data['articles']);
    }
    return [];
  }

  static Future<bool> googleSignIn() async {
    const List<String> scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
      'https://www.googleapis.com/auth/userinfo.profile',
      'openid'
    ];

    GoogleSignIn _googleSignIn = GoogleSignIn(
      // Optional clientId
      //clientId: Config.client_id,
      scopes: scopes,
    );

    //begin sign in process
    var googleAccount = await _googleSignIn.signIn();

    if (googleAccount == null) return false;
    if (googleAccount.serverAuthCode == null) return false;

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
    };

    final Map<String, String?> param = <String, String?>{
      'code': googleAccount.serverAuthCode
    };

    var url = Uri.http(Config.apiURL, Config.googleCallback, param);
    
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    print('request success');
    print(jsonDecode(response.body));
    var responsemodel = loginResponseJson(response.body);
    if (responsemodel.status == "success") {
      // API ko chạy trên nền web đc, uncomment khi chạy emulator
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<Map<String, dynamic>> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
      'Cookie': 'refreshToken=${loginDetails?.refreshToken}'
    };
    var url = Uri.http(Config.apiURL, Config.userprofileAPI);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);
      var profileData = data['profile'];
      return profileData;
    } else {
      return {};
    }
  }

  static Future<bool> updateUserProfile(UserModel user) async {
    var loginDetails = await SharedService.loginDetails();
    var url = Uri.http(Config.apiURL, Config.userprofileAPI);

    Map<String, dynamic> requestData = user.toJson();
    print(requestData);

    // Gửi yêu cầu PATCH với dữ liệu form data
    var request = http.MultipartRequest('PATCH', url);
    request.headers.addAll({
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
      'Cookie': 'refreshToken=${loginDetails?.refreshToken}'
    });
    requestData.forEach((key, value) {
      if (value != null) {
        if (value is File) {
          request.files.add(http.MultipartFile.fromBytes(
            key,
            value.readAsBytesSync(),
            filename: 'avatar.jpg',
            contentType: MediaType('image', 'jpeg'),
          ));
        } else {
          request.fields[key] = value.toString();
        }
      }
    });

    // Gửi yêu cầu và nhận phản hồi từ API
    var response = await request.send();
    return response.statusCode == 200;
  }
}
