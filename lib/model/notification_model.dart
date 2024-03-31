List<NotificationModel> notificationFromJson(dynamic str) =>
    str == null ? [] :
    List<NotificationModel>.from((str).map((x) => NotificationModel.fromJson(x)));
class NotificationModel {
  final  String description;
  final String createAt;

  NotificationModel({required this.description,required this.createAt});

  NotificationModel.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        createAt = json['createAt'];
}