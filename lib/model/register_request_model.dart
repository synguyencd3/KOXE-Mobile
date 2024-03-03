import 'dart:convert';

RegisterRequest registerRequestJson(String str) =>
    RegisterRequest.fromJson(json.decode(str));

class RegisterRequest {
  late final String name;
  late final String username;
  late final String password;

  RegisterRequest({required this.username, required this.password, required this.name});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    name = json['fullname'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}
