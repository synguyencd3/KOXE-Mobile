import 'dart:convert';

LoginRequest loginRequestJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

class LoginRequest {
  late final String email;
  late final String password;

  LoginRequest({required this.email, required this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['username']; //'email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.email; //'email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
