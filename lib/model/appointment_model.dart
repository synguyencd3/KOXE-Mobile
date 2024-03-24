List<AppointmentModel> appointmentsFromJson(dynamic str) =>
    List<AppointmentModel>.from((str).map((x) => AppointmentModel.fromJson(x)));
class AppointmentModel {
  final String description;
  final String datetime;
  final bool accepted;
  final String id;
  final String user;
  final String salon;

  AppointmentModel({
    required this.description,
    required this.datetime,
    required this.accepted,
    required this.id,
    required this.user,
    required this.salon,
  });
  AppointmentModel.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        datetime = json['date'],
        accepted = json['accepted'],
        id = json['id'],
        user = json['user'],
        salon = json['salon'];
}