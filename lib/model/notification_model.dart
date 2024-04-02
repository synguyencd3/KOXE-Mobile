List<NotificationModel> notificationFromJson(dynamic str) =>
    str == null ? [] :
    List<NotificationModel>.from((str).map((x) => NotificationModel.fromJson(x)));
class NotificationModel {
  final  String description;
  final String createAt;
  late bool isRead;
  final String? image;
  final String id;

  NotificationModel({required this.description,required this.createAt, required this.isRead, this.image, required this.id });

  NotificationModel.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        isRead = json['read'],
        image = json['avatar'],
        id = json['id'],
        createAt = json['create_at'];
}