import 'dart:convert';

LoginResponse loginResponseJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

class LoginResponse {
  late final String? message;
  late final String? data;

  LoginResponse({required this.message, required this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
