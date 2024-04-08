class MessaageModel{
  String sender;
  String message;
  String createdAt;
  bool status;

  MessaageModel({
    required this.sender,
    required this.message,
    required this.createdAt,
    required this.status
  });

  MessaageModel.fromJson(Map<String, dynamic> json)
      : sender = json['sender'],
        message = json['message'],
        createdAt = json['time'],
        status = json['conversation_status'];

}