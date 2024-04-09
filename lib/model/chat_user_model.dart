import 'package:mobile/model/message_model.dart';
List<ChatUserModel> chatUserFromJson(dynamic str) =>
    List<ChatUserModel>.from((str).map((x) => ChatUserModel.fromJson(x)));

class ChatUserModel {
  final String id;
  final String name;
  final String? username;
  final String? image;
  final MessaageModel? message;
  late bool? isOnline = false;


  ChatUserModel({
    required this.id,
    required this.name,
    this.username,
    this.image,
    this.message,
  });

  ChatUserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
      message = json['message'] != null
          ? MessaageModel.fromJson(json['message'])
          : null,
        image = json['image'],
        username = json['username'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'username': username
      };
}
