import 'dart:convert';

LoginRequest loginRequestJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

class LoginRequest {
  late final String username;
  late final String password;
  String? androidFcmToken;

  LoginRequest({required this.username, required this.password, this.androidFcmToken});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username']; //'email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username; //'email'] = this.email;
    data['password'] = this.password;
    if (androidFcmToken !=null) data['androidFcmToken'] = this.androidFcmToken;
    return data;
  }
}
