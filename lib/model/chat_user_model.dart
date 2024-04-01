List<ChatUserModel> chatUserFromJson(dynamic str) =>
    List<ChatUserModel>.from((str).map((x) => ChatUserModel.fromJson(x)));

class ChatUserModel {
  final String id;
  final String name;
  final String? image;
  late String? lastMessage = '';
  late String? createdAt = '';
  late bool? isOnline = false;
  late String? salonId = '';

  ChatUserModel({
    required this.id,
    required this.name,
    this.image,
    this.lastMessage,
    this.salonId,
  });

  ChatUserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        lastMessage = '',
        image = json['image'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };
}
