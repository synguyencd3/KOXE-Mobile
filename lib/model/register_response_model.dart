import 'dart:convert';

RegisterResponse registerResponseJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

class RegisterResponse {
  late final String message;
  late final String status;

  RegisterResponse({required this.message, required this.status});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    message = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
