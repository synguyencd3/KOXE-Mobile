List<ChatModel> chatsFromJson(dynamic str) => str == null
    ? []
    : List<ChatModel>.from((str).map((x) => ChatModel.fromJson(x)));

class ChatModel {
  final String sender;
  final String receiver;
  late String message;
  late String? createdAt;
  List<String>? images;

  ChatModel(
      {required this.sender,
      required this.receiver,
      required this.message,
      this.createdAt});

  ChatModel.fromJson(Map<String, dynamic> json)
      : sender = json['senderId'],
        receiver = json['receiverId'],
        message = json['message'],
        createdAt = json['createdAt'],
        images =
            json['image'] == null ? [] : List<String>.from(json['image']);
}
