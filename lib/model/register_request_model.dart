import 'dart:convert';

RegisterRequest registerRequestJson(String str) =>
    RegisterRequest.fromJson(json.decode(str));

class RegisterRequest {
  late final String email;
  late final String password;

  RegisterRequest({
    required this.email, 
    required this.password
    });

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}