
List<AppointmentModel> appointmentsFromJson(dynamic str) =>
    List<AppointmentModel>.from((str).map((x) => AppointmentModel.fromJson(x)));
class AppointmentModel {
  final String? description;
  final DateTime datetime;
  late int? status;
  final String? id;
  final String salon;
  late int dayDiff;

  AppointmentModel({
     this.description,
    required this.datetime,
    this.status,
    this.id,
    required this.salon,
  });
  AppointmentModel.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        datetime = DateTime.parse(json['date']),
        status = json['status'],
        id = json['id'],
        salon = json['salon'];

  Map<String, dynamic> toJson() => {
        'description': description,
        'date': datetime.toString(),
        'salonId': salon,
  };
}