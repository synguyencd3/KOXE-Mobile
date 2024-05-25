import 'dart:async';
import 'dart:convert';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/login_request_model.dart';
import 'package:mobile/model/login_response_model.dart';
import 'package:mobile/model/articles_model.dart';
import 'package:mobile/model/register_response_model.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:retry/retry.dart'; 
import '../config.dart';
import '../model/register_request_model.dart';
import 'package:mobile/model/user_model.dart';
import 'package:http_parser/http_parser.dart';

class APIService {
  static var client = http.Client();

  static bool refreshing = false;



  static Future<void> refreshToken() async {
    if (refreshing==true) {
      print('is on refresh');
      return;
    }
    refreshing = true;
    try {
      var loginDetails = await SharedService.loginDetails();
      var updateTime = await SharedService.updatedTime();
      if (updateTime!.add(const Duration(minutes: 15)).isAfter(DateTime.now())) 
      {
      print("Token still fresh");
      return;
      }

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${loginDetails?.accessToken}',
        'Cookie': 'refreshToken=${loginDetails?.refreshToken}'
      };

      var url = Uri.https(Config.apiURL, Config.refreshToken);
      print("request new token");
      // final response = await retry(
      //   () => http.post(url, headers: requestHeaders).timeout(Duration(seconds: 5)),
      //   retryIf: (e) => e is SocketException || e is TimeoutException,
      // );
      var response = await client.post(url, headers: requestHeaders);
      var data = jsonDecode(response.body);
      print(data);
      if (data['status']=="failed") 
      {
        return;
      }
      print("refresh token");
      loginDetails?.accessToken=data['accessToken'];
      loginDetails?.refreshToken=data['refreshToken'];
      print('update cache');
      SharedService.setLoginDetails(loginDetails!);
      SharedService.updateTime();
      print("token refreshed");
    }
    catch (e)
    {
      print(e);
    }
    finally 
    {
      print("reset flag");
      refreshing = false;
    }
  }

  static Future<bool> login(LoginRequest model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
    };

    var url = Uri.https(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    var check = jsonDecode(response.body);
    if (check['status'] == "success") {

      // API ko chạy trên nền web đc, uncomment khi chạy emulator
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    };
    // var responsemodel = loginResponseJson(response.body);
    // if (responsemodel.status == "success") {
    //   // API ko chạy trên nền web đc, uncomment khi chạy emulator
    //   await SharedService.setLoginDetails(loginResponseJson(response.body));
    //   return true;
    // } else {
    //   return false;
    // }
  }

  static Future<RegisterResponse> register(RegisterRequest model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiURL, Config.registerAPI);

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

    //var url = Uri.https(Config.newsURL, Config.newsAPi, param);
    var url = Uri.parse(Config.news);

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

    var url = Uri.https(Config.apiURL, Config.googleCallback, param);
    
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    var responsemodel = loginResponseJson(response.body);
    if (responsemodel.status == "success") {
      // API ko chạy trên nền web đc, uncomment khi chạy emulator
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> googleLinkIn() async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    final googleCurrentUser =
        GoogleSignIn().currentUser ?? await GoogleSignIn().signIn();
    if (googleCurrentUser != null)
      await GoogleSignIn().disconnect();
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
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    final Map<String, String?> param = <String, String?>{
      'code': googleAccount.serverAuthCode
    };

    var url = Uri.https(Config.apiURL, Config.googleCallback, param);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    print(response.body);
    if (jsonDecode(response.body)['status'] == "success") {
      await updateEmail(googleAccount.email);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateEmail(String email) async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    if (email == "" )
      {
        var data = await getUserProfile();
        email = data['google'];
        print(email);
      }
    print(LoginInfo?.accessToken);

    Map<String, String> requestHeaders = {
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.userprofileAPI);
    var response = await client.patch(
        url,
        headers: requestHeaders,
        body: {
          "email" : email
        }
    );
    print(response.body);
    if (jsonDecode(response.body)['status'] == "success") {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> facebookSignIn() async {

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

    if (result.status != LoginStatus.success) 
      return false;


    var url = Uri.https(Config.apiURL, Config.facebookAPI);

    String accessToken = result.accessToken?.toJson()['token'];
    print(accessToken);
    var response = await client.post(
      url,
      body: {
        "accessToken" : accessToken
      }
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

  static Future<bool> facebookLinkIn() async {

    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

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

    if (result.status != LoginStatus.success)
      return false;


    var url = Uri.https(Config.apiURL, Config.facebookAPI);

    String accessToken = result.accessToken?.toJson()['token'];
    print("fb token:"+accessToken);
    var response = await client.post(
        url,
        body: {
          "accessToken" : accessToken
        },
        headers: requestHeaders
    );

    print(response.body);
    if (jsonDecode(response.body)['status'] == "success") {
      return true;
    } else {
      return false;
    }
  }

  static Future<Map<String, dynamic>> getUserProfile() async {
    await refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
      'Cookie': 'refreshToken=${loginDetails?.refreshToken}'
    };
    var url = Uri.https(Config.apiURL, Config.userprofileAPI);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      //print(response.body);
      var data = jsonDecode(response.body);
      var profileData = data['profile'];
      return profileData;
    } else {
      return {};
    }
  }

  static Future<bool> updateUserProfile(UserModel user) async {
    await refreshToken();
    var loginDetails = await SharedService.loginDetails();
    var url = Uri.https(Config.apiURL, Config.userprofileAPI);

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

  static Future<bool> sendInvite(String email) async {
    await refreshToken();
    var url = Uri.https(Config.apiURL, Config.sendInvite);
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var salon = await SalonsService.isSalon();
    print(salon);
    final Map<String, String?> param = <String, String?>{
      'email': email,
      'salonId': salon
    };

    var response = await client.post(url, headers: requestHeaders, body: jsonEncode(param));
    print(response.body);
    var data = jsonDecode(response.body);

    if (data['status'] == "success") return true;
    return false;
  }
  static Future<bool> changePassword(String oldPassword, String newPassword) async {
    await refreshToken();
    var url = Uri.https(Config.apiURL, Config.changePasswordAPI);
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    final Map<String, String?> param = <String, String?>{
      'oldPassword': oldPassword,
      'newPassword': newPassword
    };

    var response = await client.post(url, headers: requestHeaders, body: jsonEncode(param));
   return response.statusCode == 200;
  }
}
