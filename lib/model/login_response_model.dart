import 'dart:convert';

import 'package:mobile/model/user_model.dart';
import 'package:mobile/widgets/user.dart';
import 'package:mobile/model/user_model.dart';

LoginResponse loginResponseJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

class LoginResponse {
  late final String status;
  late final UserModel? user;
  late final String? accessToken;
  late final String message;

  LoginResponse(
      {required this.message,
      required this.status,
      required this.accessToken,
      required this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['msg'];
    user = UserModel.fromJson(json['user']); 
    accessToken = json['accessToken'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.message;
    data['user'] = this.user;
    data['accessToken'] = this.accessToken;
    data['status'] = this.status;
    return data;
  }
}
