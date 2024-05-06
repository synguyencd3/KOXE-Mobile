import 'dart:convert';

List<UserPostModel> userPostModelFromJson(String str) =>
    List<UserPostModel>.from(
        json.decode(str).map((x) => UserPostModel.fromJson(x)));

class UserPostModel {
  String userId;
  String fullname;
  String avatar;

  UserPostModel(
      {required this.userId, required this.fullname, required this.avatar});

  factory UserPostModel.fromJson(Map<String, dynamic> json) {
    return UserPostModel(
        userId: json['user_id'],
        fullname: json['fullname'],
        avatar: json['avatar']);
  }
}
