
import 'dart:convert';

import 'package:mobile/model/user_post_model.dart';
import 'package:mobile/model/car_model.dart';

List<PostModel> postModelFromJson(dynamic str) =>
    List<PostModel>.from((str).map((x) => PostModel.fromJson(x)));
class PostModel {
  Car? car;
  final String postId;
  final String text;
  final DateTime createAt;
  final UserPostModel user;
  late List<String> listSalonId;

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

  Map<String, dynamic> toJson() => {
    "text": text,
    "salons ": listSalonId,
    "car": car?.tojson() ?? "",
  };


}