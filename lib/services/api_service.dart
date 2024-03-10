import 'dart:convert';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/login_request_model.dart';
import 'package:mobile/model/login_response_model.dart';
import 'package:mobile/model/articles_model.dart';
import 'package:mobile/model/register_response_model.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb; 
import '../config.dart';
import '../model/register_request_model.dart';

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
        clientId: Config.client_id,
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

    var url = Uri.http(Config.apiURL, Config.callback, param);
    
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

  static Future<bool> facebookSignIn() async {
    Map<String, dynamic?> userData;
    bool checking = true;

     if (kIsWeb) {
    // initialiaze the facebook javascript SDK
   await FacebookAuth.i.webAndDesktopInitialize(
      appId: "312164338180427",
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );
  }

    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      print(result.accessToken?.toJson());

      final userData = await FacebookAuth.instance.getUserData();
      print(userData);

      return false;
    } else {
      print(result.status);
      print(result.message);
    }

    return false;
  }
}
