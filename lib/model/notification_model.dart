List<NotificationModel> notificationFromJson(dynamic str) =>
    str == null ? [] :
    List<NotificationModel>.from((str).map((x) => NotificationModel.fromJson(x)));
class NotificationModel {
  final String? description;
  final DateTime createAt;
  late bool isRead;
  final String avatar;
  final String id;
  final String types;
  final String appointmentId ;

  NotificationModel({ this.description,required this.createAt, required this.isRead,required this.avatar, required this.id , required this.types , required this.appointmentId});

  NotificationModel.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        isRead = json['read'],
        avatar = json['avatar'],
        id = json['id'],
        types = json['types'],
        appointmentId = json['data'],
        createAt = DateTime.parse(json['create_at']);
}