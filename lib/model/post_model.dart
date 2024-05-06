
import 'dart:convert';

import 'package:mobile/model/user_post_model.dart';

List<PostModel> postModelFromJson(dynamic str) =>
    List<PostModel>.from((str).map((x) => PostModel.fromJson(x)));
class PostModel {
  final String postId;
  final String text;
  final DateTime createAt;
  final UserPostModel user;

  PostModel({
    required this.postId,
    required this.text,
    required this.createAt,
    required this.user,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['post_id'],
      text: json['text'],
      createAt: DateTime.parse(json['createdAt']),
      user: UserPostModel.fromJson(json['postedBy']),
    );
  }


}