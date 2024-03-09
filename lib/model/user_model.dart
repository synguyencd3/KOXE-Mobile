import 'dart:convert';

UserModel userJson(dynamic str) => UserModel.fromJson(json.decode(str));

class UserModel {
  late final String id;
  late final String username;
  late final String fullname;
  late final String? gender;
  late final String? phone;
  late final String? email;
  late final String? address;
  late final String? avatar;
  late final String role;

  UserModel(
      {required this.id,
      required this.username,
      required this.fullname,
      this.address,
      this.avatar,
      this.email,
      this.gender,
      this.phone,
      required this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['user_id'];
    username = json['username'];
    fullname = json['fullname'];
    gender = json['gender'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    avatar = json['avatar'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.id;
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['avatar'] = this.avatar;
    data['role'] = this.role;
    return data;
  }
}
