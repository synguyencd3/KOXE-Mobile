import 'package:mobile/model/car_model.dart';

List<AppointmentModel> appointmentsFromJson(dynamic str) =>
    List<AppointmentModel>.from((str).map((x) => AppointmentModel.fromJson(x)));

class AppointmentModel {
  final String? description;
  final DateTime datetime;
  late int? status;
  final String? id;
  final String salon;
  late int dayDiff;
  late String carId;
  final Car? car;
  late String? phone;
  late String? from;

  AppointmentModel({
    this.description,
    required this.datetime,
    this.status,
    this.id,
    required this.salon,
    this.carId = '',
    this.car,
    this.phone
  });

  AppointmentModel.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        datetime = DateTime.parse(json['date']),
        status = json['status'],
        id = json['id'],
        car = json['car'] != null ? Car.fromJson(json['car']) : null,
  from = json['from'],
        salon = json['salon'];

  Map<String, dynamic> toJson() => {
        'description': description,
        'date': datetime.toString(),
        'carId': carId,
        'salonId': salon,
        if (phone != null) 'phone': phone,
      };
}
