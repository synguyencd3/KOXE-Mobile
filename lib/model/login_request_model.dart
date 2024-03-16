import 'dart:convert';

LoginRequest loginRequestJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

class LoginRequest {
  late final String username;
  late final String password;

  LoginRequest({required this.username, required this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username']; //'email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username; //'email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
