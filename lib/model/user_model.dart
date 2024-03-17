import 'dart:convert';
import 'dart:io';

UserModel userJson(dynamic str) => UserModel.fromJson(json.decode(str));

class UserModel {
    String? id;
    String? username;
    String? fullname;
    String? gender;
    String? phone;
    String? email;
    String? address;
    String? avatar;
    String? role;
    String? date_of_birth;
    File? avatarFile;

  UserModel(
      { this.id,
       this.username,
       this.fullname,
      this.address,
      this.avatar,
      this.email,
      this.gender,
      this.phone,
       this.role,
      this.date_of_birth});

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
    date_of_birth = json['date_of_birth'];
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
    data['avatar'] = this.avatarFile;
    data['role'] = this.role;
    data['date_of_birth'] = this.date_of_birth;
    return data;
  }
}
