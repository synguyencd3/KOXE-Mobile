import 'package:mobile/model/message_model.dart';

List<ChatUserModel> chatUserFromJson(dynamic str) =>
    List<ChatUserModel>.from((str).map((x) => ChatUserModel.fromJson(x)));

class ChatUserModel {
  final String id;
  final String name;
  final String? username;
  final String? image;
  final MessageModel? message;
  late bool? isOnline = false;
  late String? carId = '';

  ChatUserModel({
    required this.id,
    required this.name,
    this.username,
    this.image,
    this.message,
    this.carId,
  });

  ChatUserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        message = json.containsKey('message')
            ? MessageModel.fromJson(json['message'])
            : MessageModel(
                sender: '', message: 'Chưa có tin nhắn nào', createdAt: '', status: false),
        image = json['image'],
        username = json['username'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'image': image, 'username': username};
}
