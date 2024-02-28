import 'dart:convert';

RegisterResponse registerResponseJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

class RegisterResponse {
  late final String message;
  late final String data;

  RegisterResponse({
    required this.message, 
    required this.data
    });

  RegisterResponse.fromJson(Map<String, dynamic> json) {
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